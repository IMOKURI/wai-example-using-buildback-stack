{-# LANGUAGE OverloadedStrings #-}

module Main where

import Network.Wai
import Network.Wai.Handler.Warp (run, Port)
import Network.HTTP.Types
import System.Environment (getEnvironment)
import Data.List (lookup)
import Data.Maybe

main :: IO ()
main = do
  port <- getPort
  run port app

getPort :: IO Port
getPort = getEnvironment >>= return . port'
  where
    port' = fromMaybe defaultPort . fmap read . lookup "PORT"

defaultPort :: Port
defaultPort = 3000

app :: Application
app request respond = respond $ case rawPathInfo request of
  "/"     -> index
  _       -> notFound

index :: Response
index = responseLBS
  status200
  [("Content-Type", "text/plain")]
  "Hello web!"

notFound :: Response
notFound = responseLBS
  status404
  [("Content-Type", "text/plain")]
  "404 - Not Found"

