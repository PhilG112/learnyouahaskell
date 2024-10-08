module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune
            deriving (Eq)

ageOn :: Planet -> Float -> Float
ageOn planet seconds = (seconds / earthSeconds) / snd getPlanet
    where
        getPlanet = planetMapLookup planet planetMap


planetMap :: [(Planet, Float)]
planetMap = [
    (Mercury, 0.2408467),
    (Venus, 0.61519726),
    (Earth, 1),
    (Mars, 1.8808158),
    (Jupiter, 11.862615),
    (Saturn, 29.447498),
    (Uranus, 84.016846),
    (Neptune, 164.79132)
    ]

planetMapLookup :: Planet -> [(Planet, Float)] -> (Planet, Float)
planetMapLookup planet planetMap = head $ filter (\x -> fst x == planet) planetMap

earthSeconds :: Float
earthSeconds = 31557600


-- Other solution
earthYearsFromSeconds :: Float -> Float
earthYearsFromSeconds seconds = seconds / 31557600  

ageOn2 :: Planet -> Float -> Float
ageOn2 planet seconds = earthYears / case planet of
  Earth   -> 1
  Mercury -> 0.2408467
  Venus   -> 0.61519726
  Mars    -> 1.8808158 
  Jupiter -> 11.862615
  Saturn  -> 29.447498
  Uranus  -> 84.016846
  Neptune -> 164.79132
  where
    earthYears = earthYearsFromSeconds seconds