{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Integrate where

import Import

getIntegrateR :: Handler Html
getIntegrateR = do
    defaultLayout $ do
        setTitle "Fluid | The Programmatic IDL"
        $(widgetFile "integrate")
