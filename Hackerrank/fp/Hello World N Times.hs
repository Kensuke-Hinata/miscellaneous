hello_worlds :: Int -> [Char]
hello_worlds n
	| n <= 0 = ""
	| otherwise = "Hello World\n" ++ hello_worlds (n - 1)

main = do
	n <- readLn :: IO Int
	putStrLn (hello_worlds n)
