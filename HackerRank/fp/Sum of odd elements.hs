f :: [Int] -> Int
f [] = 0
f (x : xs)
    | x `mod` 2 == 0 = f xs
    | otherwise = x + f xs

-- This part handles the Input/Output and can be used as it is. Do not change or modify it.
main = do
   inputdata <- getContents
   putStrLn $ show $ f $ map (read :: String -> Int) $ lines inputdata
