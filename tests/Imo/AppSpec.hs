{-# LANGUAGE OverloadedStrings #-}

module Imo.AppSpec
( imoAppSpec
) where

import Imo.App

import Network.Wai
import Network.Wai.Test
import Test.Hspec

imoAppSpec :: Spec
imoAppSpec = do
  describe "imoApp" $ do
    it "200 when served correctly" $ flip runSession imoApp $ do
      req <- request (setRawPathInfo defaultRequest "/")
      assertStatus 200 req
      assertHeader "Content-Type" "text/plain" req
      assertBody "Hello web!" req

    it "404 when invalid path" $ flip runSession imoApp $ do
      req <- request (setRawPathInfo defaultRequest "/a")
      assertStatus 404 req
      assertHeader "Content-Type" "text/plain" req
      assertBody "404 - Not Found" req

