{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Champion where

import Import
import Database.Persist.Sql (rawSql)
import Text.Julius (RawJS (..))
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

--Afrom From Entity Champion
championForm :: Maybe Champion -> AForm Handler Champion
championForm   champion = Champion
                        <$> areq textField "Nombre" (championIdName <$> champion)
                        <*> areq textField "Description" (championDescription <$> champion)
                        <*> areq textField "Vida" (championLife <$> champion)
                        <*> areq textField "Daño de Ataque" (championAttackdamage <$> champion)
                        <*> areq textField "Velocidad de Ataque" (championAttackspeed <$> champion)
                        <*> areq intField "Velocidad" (championSpeed <$> champion)
                        <*> areq textField "Regeneracion de vida" (championRegenerationlife <$> champion)
                        <*> areq textField "Armadura" (championArmor <$> champion)
                        <*> areq textField "Resistencia Magica" (championMagicresistence <$> champion)
                        <*> areq (selectFieldList rols) "Rol" (championRol <$> champion)
                        <*> areq (selectFieldList prices) "Precio" (championPrice <$> champion)
                        where
                         prices :: [(Text,Int)]
                         prices = [("450",450),("1350",1350),("3150",3150),("4800",4800),("6300",6300),("7800",7800)]
                         rols :: [(Text,Text)]
                         rols = [("Asesino","Asesino"),("Mago","Mago"),("Soporte","Soporte"),("Tirador","Tirador"),("Tanque","Tanque"),("Luchador","Luchador")]

--CRUD
--Create
getChampionNewR ::  Handler Html
getChampionNewR = do
		(widget, encoding) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ championForm Nothing
		defaultLayout $ do
			let actionR = ChampionNewR
			$(widgetFile "Champion")

postChampionNewR :: Handler Html
postChampionNewR = do
		((result,widget), encoding) <- runFormPost $ renderBootstrap3 BootstrapBasicForm $ championForm  Nothing
		case result of
		     FormSuccess champion -> do
				 _ <- runDB $ insertEntity champion
				 redirect ChampionListR
		     _ -> defaultLayout $ do
			let actionR = ChampionNewR
			$(widgetFile "Champion")

--Delete
postChampionDeleteR :: ChampionId -> Handler ()
postChampionDeleteR championId = do
                            runDB $ delete championId
                            redirect ChampionListR

--list
getChampionListR ::  Handler Html
getChampionListR  = do
                    champions <- runDB $ getAllChampions
                    ( _ , _ ) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ championForm Nothing
                    defaultLayout $ do
                       $(widgetFile "ChampionView")


getAllChampions :: DB [Entity Champion]
getAllChampions = selectList [] [Asc ChampionIdName]