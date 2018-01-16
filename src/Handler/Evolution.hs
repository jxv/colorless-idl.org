{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Evolution where

import Import

getEvolutionR :: Handler Html
getEvolutionR = do
    defaultLayout $ do
        setTitle "Fluid | The Programmatic IDL"
        $(widgetFile "evolution")
