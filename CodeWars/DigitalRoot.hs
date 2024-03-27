module CodeWars.DigitalRoot where

digitalRoot :: forall a. (Integral a) => a -> a
digitalRoot n = if s >= 0 && s <= 9 then s else digitalRoot s
    where s = go n

go :: Integral a => a -> a
go 0 = 0
go n = d + go dd
    where
        d = n `mod` 10
        dd = n `div` 10

-- Best solution
-- Very clever!
-- Congruance formula 1 + n ((n -1) mod 9)
digitalRoot' :: (Integral a) => a -> a
digitalRoot' 0 = 0
digitalRoot' n = 1 + (n - 1) `mod` 9