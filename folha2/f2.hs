-- TODO: 1, 2, 4, 6, 7, 8, 10, 14, 15, 16, 20, 23

-- ex1
somarQuadrados = sum [i^2 | i<-[1..100]]

-- ex2
-- a)
aprox :: Int -> Double
aprox n = 4 * sum [fromIntegral((-1)^n) / fromIntegral(2*n+1) | n<-[0..n]]

-- b)
aprox_ :: Int -> Double
aprox_ n =  sqrt (12 * sum [fromIntegral((-1)^n) / fromIntegral((n+1)^2) | n<-[0..n]])

-- ex4
divdrop :: Integer -> [Integer]
divdrop n = [x | x<-[1..(n-1)], mod n x == 0]

divdrop_ :: Integer -> [Integer]
divdrop_ n = filter (\x -> mod n x == 0) [1..(n-1)]

-- ex6
pitagoricos:: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = [(x,y,z) | x<-[1..n], y<-[1..n], z<-[1..n], x^2 + y^2 == z^2]

pitagoricos_:: Integer -> [(Integer, Integer, Integer)]
pitagoricos_ n = filter (\(x,y,z) -> x^2 + y^2 == z^2) [(x,y,z) | x<-[1..n], y<-[1..n], z<-[1..n]]

-- ex7
primo :: Integer -> Bool
primo n = length [x | x<-divdrop n] == 1

-- ex8
{- 
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n-1) 
-}

factorial :: Integer -> Integer
factorial n = product [1..n]

binom :: Integer -> Integer -> Integer
binom n k = div (factorial n) (factorial k * factorial (n-k)) 

pascal :: Integer -> [[Integer]]
pascal 0 = [[1]]
pascal n = pascal (n-1) ++ [[binom n k | k<-[0..n]]]

-- ex10
-- a)
and' :: [Bool] -> Bool
and' [] = True
and' (x:xs) = x && and' xs

-- b)
or' :: [Bool] -> Bool
or' [] = False
or' (x:xs) = x || or' xs

-- c)
concat' :: [[a]] -> [a]
concat' [] = []
concat' (x:xs) = x ++ concat' xs

concat'' :: [[a]] -> [a]
concat'' lists = [x | list<-lists, x<-list]

-- d)
replicate' :: Int -> a -> [a]
replicate' 0 n = []
replicate' x n = n : replicate' (x-1) n

replicate'' :: Int -> a -> [a]
replicate'' x n = [n | i<-[0..x-1]]

-- e)
(!!) :: [a] -> Int -> [a]


-- f)
elem' :: Eq a => a -> [a] -> Bool


-- ex14
{- 
nub :: Eq a => [a] -> [a]
nub lst = nub' lst []

nub' :: Eq a => [a] -> [a] -> [a]
nub' [] _ = []
nub' (x:xs) unique = if elem x unique then nub' xs unique
                     else x : nub' xs (x:unique) 
-}

nub :: Eq a => [a] -> [a]
nub [] = []
nub (x:xs) = x : nub (filter (/=x) xs)

-- ex15
intersperse :: a -> [a] -> [a]
intersperse s [] = [] 
intersperse s (x:xs) = if length xs >= 1 then x : s : intersperse s xs
                       else x : intersperse s xs

-- ex16
algarismos :: Int -> [Int]
algarismos 0 = []
algarismos n = algarismos (div n 10) ++ [n-(div n 10)*10]

-- ex20
-- a)
insert :: Ord a => a -> [a] -> [a]
insert n [] = [n]
insert n (x:xs) = if n < x then n : x : xs
                  else x : insert n xs

-- b)
isort :: Ord a => [a] -> [a]
isort [] = []
isort (x:xs) = insert x (isort xs)

-- ex23
-- a)
    -- if using zipWith (+) p1 p2, addPoly [1,1] [1,1,1,1] would result in [2,2]
    -- however, what we want is [2,2,1,1], hence the more elaborate function

addPoly :: [Int] -> [Int] -> [Int]
addPoly [] [] = []
addPoly (x:p1) [] = x : addPoly p1 [] 
addPoly [] (y:p2) = y : addPoly [] p2
addPoly (x:p1) (y:p2) = (x+y) : addPoly p1 p2

-- b)
scalePoly :: Int -> [Int] -> [Int]
scalePoly s pol = map (*s) pol

multPoly :: [Int] -> [Int] -> [Int]
multPoly [] _ = []
multPoly (x:p1) p2 = addPoly (scalePoly x p2) (0 : multPoly p1 p2)

-- HOMEWORK: 3, 5, 9, 11, 12, 13, 17, 18, 19, 21, 22