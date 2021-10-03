{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_48HourScheme (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/sylvo/.cabal/bin"
libdir     = "/home/sylvo/.cabal/lib/x86_64-linux-ghc-8.8.4/48HourScheme-0.1.0.0-inplace-48HourScheme"
dynlibdir  = "/home/sylvo/.cabal/lib/x86_64-linux-ghc-8.8.4"
datadir    = "/home/sylvo/.cabal/share/x86_64-linux-ghc-8.8.4/48HourScheme-0.1.0.0"
libexecdir = "/home/sylvo/.cabal/libexec/x86_64-linux-ghc-8.8.4/48HourScheme-0.1.0.0"
sysconfdir = "/home/sylvo/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "48HourScheme_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "48HourScheme_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "48HourScheme_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "48HourScheme_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "48HourScheme_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "48HourScheme_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
