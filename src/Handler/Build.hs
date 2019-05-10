{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Build where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

--AForm Entity for Build
buildForm :: Maybe Builds -> AForm Handler Builds
buildForm builds = Builds
                    <$> areq textField "Nombre" (buildsName <$> builds)
                    <*> areq textField "Nombre del Campeon" (buildsChampionName <$> builds)
                    <*> areq (selectFieldList line) "Linea" (buildsLine <$> builds)
                    <*> areq (selectFieldList rune) "Runa A" (buildsFirstrune <$> builds)
                    <*> areq (selectFieldList rune) "Runa B" (buildsSecondrune <$> builds)
                    <*> areq (selectFieldList runeoptional) "Opcional A" (buildsFirstoption <$> builds)
                    <*> areq (selectFieldList runeoptional) "Opcional B" (buildsSecondoption <$> builds)
                    <*> areq (selectFieldList runeoptional) "Opcional C" (buildsThirdoption <$> builds)
                    <*> areq textField "Item 1" (buildsItemone <$> builds)
                    <*> areq textField "Item 2" (buildsItemtwo <$> builds)
                    <*> areq textField "Item 3" (buildsItemthree <$> builds)
                    <*> areq textField "Item 4" (buildsItemfour <$> builds)
                    <*> areq textField "Item 5" (buildsItemfive <$> builds)
                    <*> areq textField "Item 6" (buildsItemsix <$> builds)
                    <*> areq textField " Q " (buildsAbilityq <$> builds)
                    <*> areq textField " W " (buildsAbilityw <$> builds)
                    <*> areq textField " E " (buildsAbilitye <$> builds)
                    <*> areq textField " R " (buildsAbilityr <$> builds)
                    <*> areq textField "Descripcion de la Build" (buildsDescription <$> builds)
                    where
                     line ::[(Text,Text)]
                     line = [("Top","Top"),("Jungla","Jungla"),("Mid","Mid"),("Adc","Adc"),("Support","Support")]
                     rune ::[(Text,Text)]
                     rune = [("Dominacion","Dominacion"),("Inspiracion","Inspiracion"),("Precision","Precision"),("Brujeria","Brujeria"),("Valor","Valor")]
                     runeoptional ::[(Text,Text)]
                     runeoptional = [("Ofensiva","Ofensiva"),("Defensiva","Defensiva"),("Magia","Magia")]

--CRUD
--Create
getBuildNewR ::  Handler Html
getBuildNewR = do
            (widget, encoding) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ buildForm  Nothing
            defaultLayout $ do
                    let actionR = BuildNewR
                    $(widgetFile "Build")

postBuildNewR :: Handler Html
postBuildNewR = do
		((result,widget), encoding) <- runFormPost $ renderBootstrap3 BootstrapBasicForm $ buildForm Nothing
		case result of
		     FormSuccess build -> do
				 _ <- runDB $ insertEntity build
				 redirect BuildListR
		     _ -> defaultLayout $ do
			let actionR = BuildNewR
			$(widgetFile "Build")

--Delete
postBuildDeleteR :: BuildsId -> Handler ()
postBuildDeleteR buildId = do
                            runDB $ delete buildId
                            redirect BuildListR
--list
getBuildListR ::  Handler Html
getBuildListR  = do
                 builds <- runDB $ getAllBuild
                 ( _ , _ ) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ buildForm Nothing
                 defaultLayout $ do
                    $(widgetFile "BuildView")


getAllBuild :: DB [Entity Builds]
getAllBuild = selectList [] [Asc BuildsName]

--Edit

getBuildEditR :: BuildsId -> Handler Html
getBuildEditR buildsId  = do
               build <- runDB $ get404 buildsId
               (widget, encoding) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ buildForm  (Just build)
               defaultLayout $ do
                   let actionR = BuildEditR buildsId
                   $(widgetFile "Build")

postBuildEditR :: BuildsId -> Handler Html
postBuildEditR buildsId  = do
                build <- runDB $ get404 buildsId
                ((result,widget), encoding) <- runFormPost $ renderBootstrap3 BootstrapBasicForm $ buildForm  (Just build)
                case result of
                     FormSuccess buildResult -> do
                                 _ <- runDB $ replace buildsId  buildResult
                                 redirect BuildListR
                     _ -> defaultLayout $ do
                        let actionR = BuildEditR buildsId
                        $(widgetFile "Build")

--Search

getBuildSearchR ::  Handler Html
getBuildSearchR = do
           (widget, encoding) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ buildForm Nothing
           defaultLayout $ do
                let actionR = BuildSearchR
                $(widgetFile "BuildSearch")

postBuildSearchR :: Handler Html
postBuildSearchR = do
                ((result,widget), encoding) <- runFormPost $ renderBootstrap3 BootstrapBasicForm $ buildForm  Nothing
                case result of
                     FormSuccess _ -> do
                                 builds <- runDB $ selectList [] []
                                 defaultLayout $ do
                                    $(widgetFile "BuildView")
                     _ -> defaultLayout $ do
                        let actionR = BuildSearchR
                        $(widgetFile "Build")

--JSON

getBuildsJsonR :: Handler Value
getBuildsJsonR = do
    builds <- runDB $ selectList [] [] :: Handler [Entity Builds]

    return $ object ["builds" .= builds]

postBuildsJsonR :: Handler Value
postBuildsJsonR = do
    build <- requireJsonBody :: Handler Builds
    _    <- runDB $ insert build

    sendResponseStatus status201 ("CREATED" :: Text)

getBuildJsonR :: BuildsId -> Handler Value
getBuildJsonR buildsId = do
    build <- runDB $ get404 buildsId

    return $ object ["builds" .= (Entity buildsId build)]

putBuildJsonR :: BuildsId -> Handler Value
putBuildJsonR buildsId = do
    build <- requireJsonBody :: Handler Builds

    runDB $ replace buildsId build

    sendResponseStatus status200 ("UPDATED" :: Text)

deleteBuildJsonR :: BuildsId -> Handler Value
deleteBuildJsonR buildsId = do
    runDB $ delete buildsId

    sendResponseStatus status200 ("DELETED" :: Text)