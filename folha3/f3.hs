import Data.List
import Data.Char

-- TODO: 1, 2, 4, 7, 8

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
{-
foldr1', foldl1' :: (a -> a -> a) -> t a -> a
foldr1' f l = foldr f (last l) (init l)
foldl1' f l = foldl f (head l) (tail l)
-}

--------------------------------------- ex6
mdc :: Integer -> Integer -> Integer
mdc a b = fst (until (\(a,b) -> b == 0) (\(a,b) -> (b, mod a b)) (a,b))

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
          after_space = dropWhile (\c -> isSpace c) (dropWhile (\c -> not (isSpace c)) str)

-- b)
despalavras :: [String] -> String
despalavras xs = foldr (\a b-> a ++ if b=="" then b else " " ++ b) "" xs

despalavras' :: [String] -> String
despalavras' xs = concat (intersperse " " xs)


--------------------------------------- ex9
{-
scanl' :: (b -> a -> b) -> b -> [a] -> [b]
scanl' f z [] = [z]
scanl' f z (x:xs) = z : scanl' f (f z x) xs
-}
