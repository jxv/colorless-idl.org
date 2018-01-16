{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Design where

import Import

getDesignR :: Handler Html
getDesignR = do
    defaultLayout $ do
        setTitle "Fluid | The Programmatic IDL"
        $(widgetFile "design")
