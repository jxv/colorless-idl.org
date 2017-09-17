module ColorlessSite.Config
  ( Config(..)
  ) where

import Network.HTTP.Client (Manager)
import ColorlessSite.Types

data Config = Config
  { configEnv :: Env
  , configManager :: Manager
  }
