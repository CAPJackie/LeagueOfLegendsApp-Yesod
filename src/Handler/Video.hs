module Handler.Video where

import Import

postVideoR :: Handler Value
postVideoR = do
    video <- (requireJsonBody :: Handler Video)
    --let video' = video { videoChampion = (Champion champId "" "") }

    insertedVideo <- runDB $ insertEntity video
    returnJson insertedVideo
    