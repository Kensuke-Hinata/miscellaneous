f :: Int -> Int -> Int -> Int
f x num power
  | x == 0 = 1
  | num ^ power > x = 0
  | otherwise = f (x - num ^ power) (num + 1) power + f x (num + 1) power

main = do
    x <- readLn :: IO Int
    n <- readLn :: IO Int
    print $ f x 1 n 
