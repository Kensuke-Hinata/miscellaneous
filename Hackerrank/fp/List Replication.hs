f :: Int -> [Int] -> [Int]
f n [] = []
f n (x : xs) = g n x ++ f n xs

g :: Int -> Int -> [Int]
g n x
	| n <= 0 = []
	| otherwise = [x] ++ g (n - 1) x

main :: IO()
main = getContents >>=
       mapM_ print. (\(n:arr) -> f n arr). map read. words
