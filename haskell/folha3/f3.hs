import Data.List
import Data.Char

-- TODO: 1, 2, 4, 7, 8

--------------------------------------- ex2
{-
dec2Int :: [Int] -> Int
dec2Int [] = 0
dec2Int (x:xs) = (x*10) + (dec2Int xs)

dec2Int :: [Int] -> Int
dec2Int l = foldl (\x y -> 10*x + y) 0 l
-}

dec2Int :: [Int] -> Int
dec2Int l = foldl ((+).(*10)) 0 l


--------------------------------------- ex3
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ _ [] = []
zipWith' _ [] _ = []
zipWith' f (x:xs) (y:ys) = (f x y) : (zipWith' f xs ys)


--------------------------------------- ex4
isort :: Ord a => [a] -> [a]
isort = foldr insert []


--------------------------------------- ex5
-- a)
maximum', minimum' :: Ord a => [a] -> a
maximum' = foldr1 max
minimum' = foldr1 min

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
concatfoldr = foldr (++) []

-- c)
reversefoldr :: [a] -> [a]
reversefoldr l = foldr (\h t -> t++[h]) [] l

-- d)
reversefoldl :: [a] -> [a]
reversefoldl l = foldl (\t h -> h:t) [] l

-- point-free alternative
reversefoldl' :: [a] -> [a]
reversefoldl' = foldl (flip (:)) []

-- e)
elemany :: Eq a => a -> [a] -> Bool
elemany e l = any (\elem -> elem==e) l

-- point free alternative
elemany' :: Eq a => a -> [a] -> Bool
elemany' = any . (==)


--------------------------------------- ex8
-- a)
palavras :: String -> [String]
palavras [] = []
palavras str = takeWhile (not.isSpace) str_ : palavras (dropWhile isSpace (dropWhile (not.isSpace) str_))
  where str_ = dropWhile isSpace str

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
