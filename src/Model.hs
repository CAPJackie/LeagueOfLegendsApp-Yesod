{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
module Model where

import ClassyPrelude.Yesod
import Database.Persist.Quasi

-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
share [mkPersist sqlSettings, mkMigrate "migrateAll"]
    $(persistFileWith lowerCaseSettings "config/models")

--
instance ToJSON (Entity Builds) where
    toJSON (Entity buildsId build) = object
        [ "id"         .= (String $ toPathPiece buildsId)
        , "Name"   .= buildsName build
        , "Champion Name"   .= buildsChampionName build
        , "line" .= buildsLine build
        , "Rune A" .= buildsFirstrune build
        , "Rune B" .= buildsSecondrune build
        , "Optional A" .= buildsFirstoption build
        , "Optional B" .= buildsSecondoption build
        , "Optional C" .= buildsThirdoption build
        , "Item 1" .= buildsItemone build
        , "Item 2" .= buildsItemtwo build
        , "Item 3" .= buildsItemthree build
        , "Item 4" .= buildsItemfour build
        , "Item 5" .= buildsItemfive build
        , "Item 6" .= buildsItemsix build
        , "Q" .= buildsAbilityq build
        , "W" .= buildsAbilityw build
        , "E" .= buildsAbilitye build
        , "R" .= buildsAbilityr build
        , "Description" .= buildsDescription build
        ]

instance FromJSON Builds where
        parseJSON (Object build) = Builds
            <$> build .: "name"
            <*> build .: "championName"
            <*> build .: "line"
            <*> build .: "firstrune"
            <*> build .: "secondrune"
            <*> build .: "firstoption"
            <*> build .: "secondoption"
            <*> build .: "thirdoption"
            <*> build .: "itemone"
            <*> build .: "itemtwo"
            <*> build .: "itemthree"
            <*> build .: "itemfour"
            <*> build .: "itemfive"
            <*> build .: "itemsix"
            <*> build .: "abilityq"
            <*> build .: "abilityw"
            <*> build .: "abilitye"
            <*> build .: "abilityr"
            <*> build .: "description"
        parseJSON _ = mzero


data Privileges =
    PrvRegisteredUser
    deriving (Show,Read,Eq)

derivePersistField "Privileges" 



