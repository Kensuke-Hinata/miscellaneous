module Main where

fib' :: Integral a => a -> [a]
fib' n
    | n <= 0 = [0, 0]
    | n == 2 = [0, 1]
    | otherwise = [last res, (head res) + (last res)]
    where res = fib' (n - 1)

fib :: Integral a => a -> a
fib n = last $ fib' n

main = do
    input <- getLine
    print . fib . (read :: String -> Int) $ input
