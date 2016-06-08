solve :: Double -> Double
solve x = -- Insert your code here --
    func x 10

-- fromIntegral :: (Integral a, Double b) => a -> b

func :: Double -> Int -> Double
func _ 0 = 0
func x n = (g (n - 1) x) / fromIntegral (f (n - 1)) + func x (n - 1)

f :: Int -> Int 
f n
    | n == 0 = 1
    | otherwise = n * f (n - 1)

g :: Int -> Double -> Double
g 0 _ = 1
g _ 0 = 0
g n x = x * g (n - 1) x

main :: IO ()
main = getContents >>= mapM_ print. map solve. map (read::String->Double). tail. words

