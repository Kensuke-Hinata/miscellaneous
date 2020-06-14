f :: String -> String
f "" = ""
f s
  | length s == 1 = s 
  | otherwise = head suffix : head s : f (tail suffix)
  where suffix = tail s

main = do
    inputdata <- getContents
    let
        ss = lines inputdata
    putStrLn . unlines $ map f $ tail ss
