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

-- |
-- Copyright: 2017 Fernando Rincon Martin
-- License: Apache-2.0
--
-- Maintainer  :  frm.rincon@gmail.com
-- Stability   :  experimental
--
-- Ping wrapper.
--
-- It calls ping utility and parse the result in a haskell data type.
--
-- Currently only support win32 platform
module Ping
  ( PingOptions(..)
  , PingResult(..)
  , performPing
  ) where

import Data.Attoparsec.Ping
import Data.Attoparsec.Text (parseOnly)
import Data.Either.Combinators (mapLeft)
import Data.List (intercalate)
import Development.Placeholders
import System.Process (readProcessWithExitCode)

import Ping.CommonTypes
import Ping.Platform

-- | Execute synchronously the ping and return the parsed result
performPing :: PingOptions -> IO (Either String PingResult)
performPing opts =
  let parameters = pingParameters opts
  in do (exitCode, stdout, stderr) <-
          readProcessWithExitCode "ping" parameters ""
        return $ addContextToLeft stdout $ parseResult stdout
  where
    addContextToLeft stdout = mapLeft (addContext stdout)
    addContext stdout errorString =
      errorString ++
      "\n" ++ "StdOut:\n" ++ unlines (fmap (\x -> "   " ++ x) (lines stdout))
