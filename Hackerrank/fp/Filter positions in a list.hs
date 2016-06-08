f :: [Int] -> [Int]
f lst = -- Fill up this Function
    g lst 0
g :: [Int] -> Int -> [Int]
g [] flag = []
g (x : xs) flag = if flag /= 0 then [x] ++ g xs (1 - flag) else g xs (1 - flag)
-- This part deals with the Input and Output and can be used as it is. Do not modify it.
main = do
   inputdata <- getContents
   mapM_ (putStrLn. show). f. map read. lines $ inputdata

