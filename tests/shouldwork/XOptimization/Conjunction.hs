{-# OPTIONS_GHC -fno-strictness #-}
module Conjunction where

import qualified Prelude as P
import Prelude ((++))

import Clash.Prelude hiding (assert, (++))
import Clash.Annotations.SynthesisAttributes

import Data.String (IsString)
import Data.List (isInfixOf)
import System.Environment (getArgs)
import System.FilePath ((</>))

import qualified Data.Text as T
import qualified Data.Text.IO as T

f x y = x && y
{-# NOINLINE f #-}

topEntity (x :: Bool) = f (let y :: Bool = y in y) True

--------------- Actual tests for generated HDL -------------------
assertNotIn :: String -> String -> IO ()
assertNotIn needle haystack
  | needle `isInfixOf` haystack = P.error $ P.concat [ "Did not Expect:\n\n  "
                                                     , needle
                                                     , "\n\nIn:\n\n"
                                                     , haystack ]
  | otherwise                   = return ()

-- VHDL test
mainVHDL :: IO ()
mainVHDL = do
  [topFile] <- getArgs
  content <- readFile topFile

  assertNotIn "true" content

-- Verilog test
mainVerilog :: IO ()
mainVerilog = do
  [topFile] <- getArgs
  content <- readFile topFile

  assertNotIn "1'b1" content

-- SystemVerilog test
mainSystemVerilog :: IO ()
mainSystemVerilog = do
  [topFile] <- getArgs
  content <- readFile topFile

  assertNotIn "1'b1" content
