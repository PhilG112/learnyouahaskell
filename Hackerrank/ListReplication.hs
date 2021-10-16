module Hackerrank.ListReplication where

t :: (Eq t, Num t) => t -> IO ()
t 0 = return ()
t n = do 
    putStrLn "Hello World"
    t (n-1)

-- n times to replicate, [list]
f :: Int -> [Int] -> [Int]
f n = concatMap $ replicate n


-- This part handles the Input and Output and can be used as it is. Do not modify this part.
main :: IO ()
main = getContents >>=
    mapM_ print. (\(n:arr) -> f n arr). map read. words