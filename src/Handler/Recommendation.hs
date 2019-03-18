{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Recommendation where

import Import
--import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)


getRecommendationR :: Handler Html
getRecommendationR = do
    defaultLayout $ do
        let recommendationsTitle = "Building recommendations!!" :: Text
        setTitle "Champions recommendations"
        $(widgetFile "recommendation")