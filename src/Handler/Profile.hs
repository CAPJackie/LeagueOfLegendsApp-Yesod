{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Profile where

import Import

import Database.Persist.Sql (rawSql, unSqlBackendKey)

getProfileR :: Handler Html
getProfileR = do
    (_, user) <- requireAuthPair
    profileInfo <- getUserProfile $ userIdent user
    defaultLayout $ do
        setTitle . toHtml $ userIdent user <> "'s User page"
        $(widgetFile "profile")

getUserProfile :: Text -> Handler [Entity Profile]
getUserProfile t = runDB $ rawSql s [toPersistValue t]
    where s = "SELECT ?? FROM profile WHERE profile.user = ?"