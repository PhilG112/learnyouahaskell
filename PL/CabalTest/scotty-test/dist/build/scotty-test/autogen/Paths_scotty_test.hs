{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_scotty_test (
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
libdir     = "/home/sylvo/.cabal/lib/x86_64-linux-ghc-8.6.5/scotty-test-0.1.0.0-IgxjbiBOZqXDTa2tCpusgL-scotty-test"
dynlibdir  = "/home/sylvo/.cabal/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/sylvo/.cabal/share/x86_64-linux-ghc-8.6.5/scotty-test-0.1.0.0"
libexecdir = "/home/sylvo/.cabal/libexec/x86_64-linux-ghc-8.6.5/scotty-test-0.1.0.0"
sysconfdir = "/home/sylvo/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "scotty_test_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "scotty_test_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "scotty_test_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "scotty_test_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "scotty_test_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "scotty_test_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
