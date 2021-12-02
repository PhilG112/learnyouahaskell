{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_AbstractionPatterns (
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
libdir     = "/home/sylvo/.cabal/lib/x86_64-linux-ghc-8.6.5/AbstractionPatterns-0.1.0.0-FGmIx6m7caD9Nl4FKuWold"
dynlibdir  = "/home/sylvo/.cabal/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/sylvo/.cabal/share/x86_64-linux-ghc-8.6.5/AbstractionPatterns-0.1.0.0"
libexecdir = "/home/sylvo/.cabal/libexec/x86_64-linux-ghc-8.6.5/AbstractionPatterns-0.1.0.0"
sysconfdir = "/home/sylvo/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "AbstractionPatterns_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "AbstractionPatterns_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "AbstractionPatterns_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "AbstractionPatterns_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "AbstractionPatterns_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "AbstractionPatterns_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
