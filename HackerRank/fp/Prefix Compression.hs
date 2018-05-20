g :: String -> String -> Int -> Int
g "" _ idx = idx
g _ "" idx = idx
g p q idx
  | head p /= head q = idx
  | otherwise = g (tail p) (tail q) (idx + 1)

f :: String -> String -> [(Int, String)]
f p q = (commonLength, take commonLength p) :
 (length p - commonLength, drop commonLength p) : 
 [(length q - commonLength, drop commonLength q)]
   where commonLength = g p q 0

main = do
    p <- getLine
    q <- getLine
    putStrLn $ unlines $ map (\t -> show (fst t) ++ " " ++ snd t) $ f p q
