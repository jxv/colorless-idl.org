{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Status where

import Import

getStatusR :: Handler Html
getStatusR = do
    defaultLayout $ do
        setTitle "Fluid IDL"
        $(widgetFile "status")
