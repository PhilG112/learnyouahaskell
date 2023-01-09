module MultiTable where

multiplicationTable :: Int -> [[Int]]
multiplicationTable n = [ [i * j | i <- [1..n]] | j <- [1..n] ]
{-
    The above is basically the same as

    for (i = 1; i <= n; i++)
    {
        for (j = 1; j <= n; j++)
        {
            ...
        }
    }
-}