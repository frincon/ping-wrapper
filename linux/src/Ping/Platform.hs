-- Copyright 2017 Fernando Rincon Martin
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
{-# LANGUAGE TemplateHaskell #-}

module Ping.Platform
  ( pingParameters
  , parseResult
  ) where

import Development.Placeholders

import Data.Attoparsec.Ping
import Data.Attoparsec.Text (parseOnly)
import qualified Data.Text as T
import Ping.CommonTypes

pingParameters :: PingOptions -> [String]
pingParameters opts = $notImplemented

parseResult :: String -> Either String PingResult
parseResult stdout = $notImplemented
