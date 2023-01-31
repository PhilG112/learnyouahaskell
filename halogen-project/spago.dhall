{ name = "halogen-project"
, dependencies = [
    "console"
    , "effect"
    , "halogen"
    , "prelude"
    , "node-fs"
    , "react-basic"
    , "react-basic-dom"
    , "react-basic-hooks" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
