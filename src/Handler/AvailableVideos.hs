{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.AvailableVideos where

import Import
import           Database.Persist.Sql (rawSql)
--import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)


getRecommendationVideoR :: Text -> Handler Html
getRecommendationVideoR championId = do
    allVideos <- selectVideosByChampId championId
    let videosTitle = "Here it should go champion's name " ++ (show (length allVideos)) :: String
    
    defaultLayout $ do
        let (videoFormId, videoNameTextareaId, videoUrlTextareaId, videoListId) = videoIds
        setTitle . toHtml $ "Champion" <> championId
        $(widgetFile "video")

postRecommendationVideoR :: Text -> Handler Html
postRecommendationVideoR championId = do

    allVideos <- selectVideosByChampId championId
    let videosTitle = "Here it should go champion's name " ++ (show (length allVideos)) :: String

    defaultLayout $ do
        let (videoFormId, videoNameTextareaId, videoUrlTextareaId, videoListId) = videoIds
        setTitle . toHtml $ "Champion" <> championId
        $(widgetFile "video")


videoIds :: (Text, Text, Text, Text)
videoIds = ("js-videoForm","js-videoName", "js-videoUrl", "js-videoList")

selectVideosByChampId :: Text -> Handler [Entity Video]
selectVideosByChampId t = runDB $ rawSql s [toPersistValue t]
    where s = "SELECT distinct ?? FROM video, champion WHERE video.champion = ?"