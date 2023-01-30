{ name = "halogen-project"
, dependencies = [ "console", "effect", "halogen", "prelude", "node-fs" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
