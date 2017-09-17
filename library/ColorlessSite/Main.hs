{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
module ColorlessSite.Main (main) where

import qualified Data.ByteString.Lazy as BL
import qualified Env
import Control.Monad.Catch (MonadThrow, MonadCatch)
import Control.Monad.Base
import Control.Monad.IO.Class (MonadIO)
import Control.Monad.Except
import Control.Monad.Reader
import Control.Monad.Trans.Control ()
import Data.Bifunctor (first)
import Data.Monoid ((<>))
import Data.Text (Text)
import Data.Text.Conversions
import Network.HTTP.Client.TLS (newTlsManager)
import Network.Wai.Handler.Warp (run)
import Servant
import Servant.HTML.Blaze
import Servant.Utils.StaticFiles (serveDirectoryWebApp)
import System.IO (hSetBuffering, stdout, BufferMode(..))

import ColorlessSite.Config
import ColorlessSite.Types

newtype AppHandler a = AppHandler { unAppHandler :: ReaderT Config (ExceptT Text IO) a }
  deriving
    ( Functor, Applicative, Monad
    , MonadIO, MonadReader Config
    , MonadError Text
    , MonadBase IO
    , MonadThrow, MonadCatch
    )

instance HasEnv AppHandler where
  getEnv = asks configEnv

type HtmlPage = Get '[HTML] RawHtml
type FrontEnd = HtmlPage

type Routes =  FrontEnd

environment :: (Env.AsEmpty e, Env.AsUnread e, Env.AsUnset e) => Env.Parser e Env
environment = Env
    <$> Env.var (Env.auto <=< Env.nonempty) "PORT" (helpDef 8080 "")
    <*> Env.var (Env.str <=< Env.nonempty) "BASE_URI" (Env.help "")
    <*> Env.var (Env.str <=< Env.nonempty) "SITE_DIR" (helpDef "./site/build" "")
  where
    helpDef def' msg = Env.def def' <> Env.help (msg ++ " (default: " ++ show def' ++ ")")

application :: Config -> Application
application config = serve (Proxy :: Proxy (Routes :<|> Raw)) (server config :<|> site (envSiteDir $ configEnv config))

server :: Config -> Server Routes
server config = enter natAppToHandler (serverT (envSiteDir $ configEnv config))
  where
    natAppToHandler :: AppHandler :~> Handler
    natAppToHandler = NT appToHandler

    appToHandler :: forall a. AppHandler a -> Handler a
    appToHandler = Handler . mapExceptT colorlessErrToServantErr . flip runReaderT config . unAppHandler
      where
        colorlessErrToServantErr :: IO (Either Text a) -> IO (Either ServantErr a)
        colorlessErrToServantErr = fmap . first $ \t -> err400 { errBody = BL.fromStrict . unUTF8 $ fromText t }

--

site :: FilePath -> Server Raw
site siteDir = serveDirectoryWebApp siteDir

root :: FilePath -> AppHandler RawHtml
root siteDir = fmap RawHtml (liftIO $ BL.readFile $ siteDir ++ "/index.html")

frontEnd :: FilePath -> ServerT FrontEnd AppHandler
frontEnd siteDir = root siteDir

serverT :: FilePath -> ServerT Routes AppHandler
serverT siteDir = frontEnd siteDir

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering
  env <- Env.parse (Env.header "Environment variables") environment
  manager <- newTlsManager
  let config = Config env manager
  liftIO $ run (envPort env) (application config)
