module ColorlessSite.Types where

import Data.Text (Text)
import qualified Data.ByteString.Lazy as BL
import Servant
import Servant.HTML.Blaze

data Env = Env
  { envPort :: Int
  , envBaseUri :: Text
  , envSiteDir :: FilePath
  } deriving (Eq, Show)

class HasEnv m where
  getEnv :: m Env

newtype RawHtml = RawHtml { unRaw :: BL.ByteString }

instance MimeRender HTML RawHtml where
  mimeRender _ = unRaw
