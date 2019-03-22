{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Equipment where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

--List
getEquipmentR :: Handler Html
getEquipmentR = do
    let equipmentTitle = "All Entities" :: Text
    allobj <- runDB $ getAllObjects
    ( _ , _ ) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ objectForm Nothing
    defaultLayout $ do
        setTitle "Equipment"
        $(widgetFile "equipment")

-- Create
objectForm :: Maybe Equipment -> AForm Handler Equipment
objectForm equipment = Equipment
                        <$> areq textField "Name" (equipmentName <$> equipment)
                        <*> areq textField "Cost" (equipmentCost <$> equipment)
                        <*> areq textField "Sell Price" (equipmentSell <$> equipment)
                        <*> aopt textField "Passive" (equipmentPassive <$> equipment)
                        <*> aopt textField "Active" (equipmentActive <$> equipment)
                        <*> aopt textField "Aura" (equipmentAura <$> equipment)

getNewEquipmentR ::  Handler Html
getNewEquipmentR = do
  (widget, encoding) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ objectForm Nothing
  defaultLayout $ do
    let actionR = NewEquipmentR
    setTitle "New Equipment"
    $(widgetFile "newEquipment")

postNewEquipmentR :: Handler Html
postNewEquipmentR = do
  ((result,widget), encoding) <- runFormPost $ renderBootstrap3 BootstrapBasicForm $ objectForm  Nothing
  case result of
    FormSuccess equipment -> do
      _ <- runDB $ insertEntity equipment
      redirect EquipmentR
    _ -> defaultLayout $ do
        let actionR = NewEquipmentR
        setTitle "New Equipment"
        $(widgetFile "newEquipment")

-- Delete
postDeleteEquipmentR :: EquipmentId -> Handler ()
postDeleteEquipmentR equipmentId = do
                            runDB $ delete equipmentId
                            redirect EquipmentR

-- DB

getAllObjects :: DB [Entity Equipment]
getAllObjects = selectList [] [Asc EquipmentCost, Asc EquipmentSell]
