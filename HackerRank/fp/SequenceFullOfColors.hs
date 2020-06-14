h :: String -> Int -> Int -> Int -> Int -> Bool
h "" r g y b
  | r /= g || y /= b = False
  | otherwise = True
h s r g y b
  | abs (r - g) > 1 || abs (y - b) > 1 = False
  | current == 'R' = h (tail s) (r + 1) g y b
  | current == 'G' = h (tail s) r (g + 1) y b
  | current == 'Y' = h (tail s) r g (y + 1) b
  | current == 'B' = h (tail s) r g y (b + 1)
  where current = head s

f :: String -> Bool
f s = h s 0 0 0 0

main = do
    inputdata <- getContents
    let
        ss = lines inputdata
    putStrLn . unlines $ map (show . f) $ tail ss
