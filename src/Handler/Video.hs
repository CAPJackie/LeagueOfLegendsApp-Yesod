module Handler.Video where

    import Import
    
    postVideoR :: Text -> Handler Value
    postVideoR champId = do
        video <- (requireJsonBody :: Handler Video)
        --let video' = video { videoChampion = (Champion champId "" "") }
    
        insertedVideo <- runDB $ insertEntity video
        returnJson insertedVideo
    