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
    let recommendationsTitle = "Select a champion:" :: Text
    allChampions <- runDB $ getAllChampions
    defaultLayout $ do
        let (championListId) = championIds
        setTitle "Champions recommendations"
        $(widgetFile "recommendation")



championIds :: (Text)
championIds = ("js-championList")

getAllChampions :: DB [Entity Champion]
getAllChampions = selectList [] [Asc ChampionIdName]