add a b = a + b

main = do
	val0 <- readLn
	val1 <- readLn
	let sum = add val0 val1
	print sum
