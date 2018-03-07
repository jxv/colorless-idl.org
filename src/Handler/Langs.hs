{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Langs where

import Import

getLangsR :: Handler Html
getLangsR = do
    defaultLayout $ do
        setTitle "Fluid IDL"
        $(widgetFile "langs")
