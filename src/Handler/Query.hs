{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Query where

import Import

getQueryR :: Handler Html
getQueryR = do
    defaultLayout $ do
        setTitle "Fluid | The Programmatic IDL"
        $(widgetFile "query")
