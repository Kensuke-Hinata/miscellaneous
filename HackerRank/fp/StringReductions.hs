import Data.Char
import Data.Bits

getDigit :: Char -> Int
getDigit c = ord c - 97

g :: String -> Int -> String
g "" _ = ""
g s mask
  | (.&.) (shiftL 1 $ getDigit (head s)) mask /= 0 = g (tail s) mask
  | otherwise = head s : g (tail s) ((.|.) mask (shiftL 1 $ getDigit (head s)))

f :: String -> String
f s = g s 0

main = do
    s <- getLine
    putStrLn $ f s
