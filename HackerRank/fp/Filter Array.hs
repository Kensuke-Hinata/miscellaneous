f :: Int -> [Int] -> [Int]
f n [] = []
f n (x:xs) = if x < n then [x] ++ f n xs else f n xs

main = do 
    n <- readLn :: IO Int 
    inputdata <- getContents 
    let 
        numbers = map read (lines inputdata) :: [Int] 
    putStrLn . unlines $ (map show . f n) numbers
