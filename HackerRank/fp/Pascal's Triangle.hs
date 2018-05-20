g :: [Int] -> Int -> [Int]
g [] idx = []
g arr idx
    | idx < 0 = []
    | idx > (length arr) = []
    | idx == 0 = (arr !! idx) : g arr (idx + 1)
    | idx == length arr = [last arr]
    | otherwise = (arr !! idx + arr !! (idx - 1)) : g arr (idx + 1) 

f :: Int -> [[Int]]
f k
    | k <= 0 = [[]]
    | k == 1 = [[1]]
    | otherwise = result ++ [g (last result) 0]
    where result = f (k - 1)

main = do
    k <- readLn :: IO Int
    putStrLn $ foldr (\x xs -> x ++ "\n" ++ xs) "" $ map (foldr (\x xs -> (show x) ++ " " ++ xs) "") $ f k
