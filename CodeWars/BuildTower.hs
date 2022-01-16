module CodeWars.BuildTower where

-- Not my solution https://www.codewars.com/kata/576757b1df89ecf5bd00073b/solutions/haskell

buildTower :: Int -> [String]
buildTower n = [space x ++ star x ++ space x | x <- [1..n]]
    where space x = replicate (n-x) ' '
          star x = replicate (2*x-1) '*'