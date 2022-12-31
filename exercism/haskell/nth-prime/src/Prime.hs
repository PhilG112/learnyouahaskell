module Prime (nth) where

nth :: Int -> Maybe Integer
nth 0 = Nothing
nth 1 = Just 2
nth n = Just $ primes !! (n-1)


primes :: [Integer]
primes = sieve [2..]
    where
        sieve [] = []
        sieve (p:xs) = p : sieve [x | x <- xs, x `mod` p > 0]