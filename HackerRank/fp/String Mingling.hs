f :: String -> String -> String
f "" "" = ""
f "" q = head q : f "" (tail q)
f p "" = head p : f (tail p) ""
f p q = head p : head q : f (tail p) (tail q)

main = do
    p <- getLine
    q <- getLine
    putStrLn $ f p q
