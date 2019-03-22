{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Video where

import Import

import        Database.Persist.Sql (rawSql)

postVideoR :: Handler Value
postVideoR = do
    video <- (requireJsonBody :: Handler Video)
    --let video' = video { videoChampion = (Champion champId "" "") }
    insertedVideo <- runDB $ insertEntity video
    returnJson insertedVideo
    
    