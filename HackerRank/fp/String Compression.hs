g :: String -> Int -> Char -> String
g "" n c = c : if n > 1 then show n else ""
g s n c
  | head s /= c = c : (if n > 1 then show n else "") ++ g (tail s) 1 (head s)
  | otherwise = g (tail s) (n + 1) c

f :: String -> String
f "" = ""
f s = g s 0 $ head s 

main = do
    s <- getLine
    putStrLn $ f s
