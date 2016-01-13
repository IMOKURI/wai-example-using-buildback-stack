{-# LANGUAGE OverloadedStrings #-}

module Imo.App
( imoApp
) where

import Network.Wai
import Network.HTTP.Types

imoApp :: Application
imoApp request respond = respond $ case rawPathInfo request of
  "/" -> index
  _   -> notFound

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

