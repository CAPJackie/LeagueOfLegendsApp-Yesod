{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Equipment where

import Import
--import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)


getEquipmentR :: Handler Html
getEquipmentR = do
    let equipmentTitle = "Objects list" :: Text
    allobj <- runDB $ getAllObjects
    defaultLayout $ do
        let (objectListId) = objectIds
        setTitle "Equipment"
        $(widgetFile "equipment")



objectIds :: (Text)
objectIds = ("js-objectsList")

getAllObjects :: DB [Entity Equipment]
getAllObjects = selectList [] [Asc EquipmentCost, Asc EquipmentSell]
