{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
module Handler.IpCalculator where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

--List
getIpCalculatorR :: Handler Html
getIpCalculatorR = do
    champions <- runDB $ getAllChampions
    --( _ , _ ) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ objectForm Nothing
    defaultLayout $ do
        setTitle "Ip Calculator"
        $(widgetFile "ipcalculator")



getAllChampions :: DB [Entity Champion]
getAllChampions = selectList [] [Asc ChampionIdName]