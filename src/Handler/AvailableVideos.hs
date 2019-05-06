{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.AvailableVideos where

import Import
import        Database.Persist.Sql (rawSql, unSqlBackendKey)
import Text.Julius (RawJS (..))


getRecommendationVideoR :: ChampionId -> Handler Html
getRecommendationVideoR championId = do
    champion <- runDB $ get404 championId

    allVideos <- selectVideosByChampId championId
    let videosTitle = championIdName champion :: Text
    
    defaultLayout $ do
        let (videoFormId, videoNameTextareaId, videoUrlTextareaId, videoListId, deleteRecommendationFormId, deleteTextareaId) = videoIds
        let actualChampion = show (unSqlBackendKey $ unChampionKey $ championId)
        setTitle . toHtml $ "Champion" <> show (unSqlBackendKey $ unChampionKey $ championId)
        $(widgetFile "video")

postRecommendationVideoR :: ChampionId -> Handler Html
postRecommendationVideoR championId = do
    champion <- runDB $ get404 championId

    allVideos <- selectVideosByChampId championId
    let videosTitle = championIdName champion :: Text
    defaultLayout $ do
        let (videoFormId, videoNameTextareaId, videoUrlTextareaId, videoListId, deleteRecommendationFormId, deleteTextareaId) = videoIds
        let actualChampion = show (unSqlBackendKey $ unChampionKey $ championId)
        setTitle . toHtml $ "Champion" <> show (unSqlBackendKey $ unChampionKey $ championId)
        $(widgetFile "video")



videoIds :: (Text, Text, Text, Text, Text, Text)
videoIds = ("js-videoForm","js-videoName", "js-videoUrl", "js-videoList", "js-deleteRecommendationForm", "js-deleteValue")

selectVideosByChampId :: ChampionId -> Handler [Entity Video]
selectVideosByChampId t = runDB $ rawSql s [toPersistValue t]
    where s = "SELECT distinct ?? FROM video, champion WHERE video.champion = ?"