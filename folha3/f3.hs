import Data.List
import Data.Char

-- TODO: 1, 2, 4, 7, 8, 11, 14, 15

--------------------------------------- ex2
dec2Int :: [Int] -> Int
dec2Int lst = foldl (+) 0 l 
    where l = map (\(x,i) -> x*10^i) (zip lst (reverse [0..(length lst - 1)]))

dec2int' :: [Int] -> Int
dec2int' (x:xs) = foldl (\x y -> 10*x + y) x xs


--------------------------------------- ex3
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f [] [] = []
zipWith' f (x:xs) [] = []
zipWith' f [] (y:ys) = []
zipWith' f (x:xs) (y:ys) = (f x y) : (zipWith' f xs ys)


--------------------------------------- ex4
isort :: Ord a => [a] -> [a]
isort (x:xs) = foldr insert [x] xs


--------------------------------------- ex5
-- a)
maximum', minimum' :: Ord a => [a] -> a
maximum' lst = foldr1 max lst
minimum' lst = foldr1 min lst

maximum'', minimum'' :: Ord a => [a] -> a
maximum'' lst = foldl1 max lst
minimum'' lst = foldl1 min lst

-- b)
{- foldr1', foldl1' :: Foldable t => (a -> a -> a) -> t a -> a
foldr1' f l = foldr f (last l) (init l) 
foldl1' f l = foldl f (head l) (tail l)  -}


--------------------------------------- ex6


--------------------------------------- ex7
-- a)
maismaisfoldr :: [a] -> [a] -> [a]
maismaisfoldr l1 l2 = foldr (:) l2 l1

-- b)
concatfoldr :: [[a]] -> [a]
concatfoldr l = foldr (++) [] l 

-- c)
reversefoldr :: [a] -> [a]
reversefoldr xs = foldr (\x xs -> xs++[x]) [] xs

-- d)
reversefoldl :: [a] -> [a]
reversefoldl xs = foldl (\xs x -> [x]++xs) [] xs

-- e)
elemany :: Eq a => a -> [a] -> Bool
elemany e l = any (\elem -> elem==e) l


--------------------------------------- ex8
-- a)
palavras :: String -> [String]
palavras [] = []
palavras str = [before_space] ++ palavras after_space
    where before_space = takeWhile (\c -> not (isSpace c)) str
          remaining = dropWhile (\c -> not (isSpace c)) str
          after_space = dropWhile (\c -> isSpace c) remaining

-- b)
despalavras :: [String] -> String
despalavras xs = foldr (\a b-> a ++ if b=="" then b else " " ++ b) "" xs

despalavras' :: [String] -> String
despalavras' xs = concat (intersperse " " xs)


--------------------------------------- ex9


--------------------------------------- ex10


--------------------------------------- ex11
calcPi1, calcPi2 :: Int -> Double
calcPi1 n = sum parcelas
    where num = map (*4) [(-1)^i | i<-[0..]]
          denom = [1,3..]
          parcelas = take n (zipWith (/) num denom)
calcPi2 n = 3 + sum parcelas
    where num = map (*4) [(-1)^i | i<-[0..]]
          denom = zipWith (*) (zipWith (*) [2,4..] [3,5..]) [4,6..]
          parcelas = take n (zipWith (/) num denom)


--------------------------------------- ex12


--------------------------------------- ex13


--------------------------------------- ex14



--------------------------------------- ex15
factorial :: Integer -> Integer
factorial n = product [1..n]

binom :: Integer -> Integer -> Integer
binom n k = div (factorial n) (factorial k * factorial (n-k)) 

pascal :: Integer -> [[Integer]]
pascal x = [[binom n k | k <- [0..n]] | n <- [0..x]]

