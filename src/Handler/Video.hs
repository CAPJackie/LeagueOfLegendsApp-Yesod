{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Video where

import Import

import        Database.Persist.Sql (rawSql, unSqlBackendKey)

postVideoR :: Handler Value
postVideoR = do
    video <- (requireJsonBody :: Handler Video)
    --let video' = video { videoChampion = (Champion champId "" "") }
    insertedVideo <- runDB $ insertEntity video
    returnJson insertedVideo
    

postVideoRemovalR :: VideoId -> Handler()
postVideoRemovalR champId = do
    runDB $ delete champId

    redirect (RecommendationVideoR (fromString (show (unSqlBackendKey $ unVideoKey $ champId))))