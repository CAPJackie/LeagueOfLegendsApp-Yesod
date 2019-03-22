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
                        <*> areq textField "Rol" (championRol <$> champion)


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
				 _ <- runDB $ insert champion
				 redirect HomeR
		     _ -> defaultLayout $ do
			let actionR = ChampionNewR
			$(widgetFile "Champion")