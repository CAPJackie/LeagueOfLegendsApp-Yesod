{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
module Handler.Calculator where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

--List
getCalculatorR :: Handler Html
getCalculatorR = do
    --( _ , _ ) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm $ objectForm Nothing
    defaultLayout $ do
        $(widgetFile "calculator")


{-getCalculatorResultR :: Text -> Int -> Int -> Int -> Handler Html
getCalculatorResultR league division wins loses = do
    defaultLayout $ do
        setTitle "Results"
        $(widgetFile "result")-}


getCalculatorResultR :: Text -> Handler Html
getCalculatorResultR league = do
    defaultLayout $ do
       $(widgetFile "result")
