{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Spec where

import Import

getSpecR :: Handler Html
getSpecR = do
    defaultLayout $ do
        setTitle "Fluid IDL"
        $(widgetFile "spec")
