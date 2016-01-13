{-# LANGUAGE OverloadedStrings #-}

module Main where

import Imo.App

import Network.Wai.Handler.Warp (run, Port)
import System.Environment (getEnvironment)
import Control.Monad (liftM)

main :: IO ()
main = do
  port <- getPort
  run port imoApp

getPort :: IO Port
getPort = liftM getPort' getEnvironment
  where
    getPort' = maybe defaultPort read . lookup "PORT"

defaultPort :: Port
defaultPort = 3000

