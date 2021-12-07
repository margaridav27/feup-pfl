import Data.Char

-- TODO: 1, 2, 4, 6, 7, 8, 10, 14, 15, 16, 20, 23

--------------------------------------- ex1
somarQuadrados = sum [i^2 | i<-[1..100]]


--------------------------------------- ex2
-- a)
aprox :: Int -> Double
aprox n = 4 * sum [fromIntegral((-1)^n) / fromIntegral(2*n+1) | n<-[0..n]]

-- b)
aprox_ :: Int -> Double
aprox_ n =  sqrt (12 * sum [fromIntegral((-1)^n) / fromIntegral((n+1)^2) | n<-[0..n]])


--------------------------------------- ex3
dotprod :: [Float] -> [Float] -> Float
dotprod x y = sum (zipWith (*) x y)


--------------------------------------- ex4
divdrop :: Integer -> [Integer]
divdrop n = [x | x<-[1..(n-1)], mod n x == 0]

divdrop_ :: Integer -> [Integer]
divdrop_ n = filter (\x -> mod n x == 0) [1..(n-1)]


--------------------------------------- ex5
perfeitos :: Integer -> [Integer]
perfeitos x = [ xi | xi<-[1..x], sum (divdrop xi) == xi]


--------------------------------------- ex6
pitagoricos:: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = [(x,y,z) | x<-[1..n], y<-[1..n], z<-[1..n], x^2 + y^2 == z^2]

pitagoricos_:: Integer -> [(Integer, Integer, Integer)]
pitagoricos_ n = filter (\(x,y,z) -> x^2 + y^2 == z^2) [(x,y,z) | x<-[1..n], y<-[1..n], z<-[1..n]]


--------------------------------------- ex7
primo :: Integer -> Bool
primo n = length [x | x<-divdrop n] == 1


--------------------------------------- ex8
{- 
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n-1) 
-}

factorial :: Integer -> Integer
factorial n = product [1..n]

binom :: Integer -> Integer -> Integer
binom n k = div (factorial n) (factorial k * factorial (n-k)) 

{- 
pascal :: Integer -> [[Integer]]
pascal 0 = [[1]]
pascal n = pascal (n-1) ++ [[binom n k | k<-[0..n]]] 
-}

pascal :: Integer -> [[Integer]]
pascal x = [[binom n k | k <- [0..n]] | n <- [0..x]]


--------------------------------------- ex9
-- só funciona com letras maiúsculas
cifrar :: Int -> String -> String
cifrar d str = [if letter == ' ' then ' ' 
                else chr ((mod ((ord letter - ord 'A') + d) 26) + ord 'A') 
                | letter<-str]


--------------------------------------- ex10
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

-- d)
replicate' :: Int -> a -> [a]
replicate' 0 n = []
replicate' x n = n : replicate' (x-1) n

-- e)
indice' :: [a] -> Int -> a
indice' lst 0 = head lst
indice' lst i = indice' (tail lst) (i-1) 

-- f)
elem' :: Eq a => a -> [a] -> Bool
elem' e [] = False
elem' e (x:xs) | e == x = True
               | otherwise = elem' e xs

elem'' :: Eq a => a -> [a] -> Bool
elem'' e [] = False
elem'' e (x:xs) = (e == x) || elem'' e xs

elem''' :: Eq a => a -> [a] -> Bool
elem''' e lst = any (\a -> a == e) lst


--------------------------------------- ex11
replicate'' :: Int -> a -> [a]
replicate'' x n = [n | i<-[0..x-1]]

concat'' :: [[a]] -> [a]
concat'' lists = [x | list<-lists, x<-list]

indice'' :: [a] -> Int -> a
indice'' lst i = head [ elem | (elem, index)<-zip lst [0..(length lst)], index == i] 


--------------------------------------- ex12
forte :: String -> Bool
forte x = (length x >= 8) && lower && upper && digit
        where lower = or [isLower xi | xi<-x]
              upper = or [isUpper xi | xi<-x]
              digit = or [isDigit xi | xi<-x]


--------------------------------------- ex13
-- a)
mindiv :: Int -> Int
mindiv x | length divisores == 0 = x
         | otherwise = head divisores
    where divisores = [ xs | xs<-[2.. round (sqrt (fromIntegral x))], (x `mod` xs) == 0]

-- b)
primo' :: Int -> Bool
primo' x = x > 1 && mindiv x == x


--------------------------------------- ex14
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


--------------------------------------- ex15
intersperse :: a -> [a] -> [a]
intersperse c (x:xs) | length xs == 0 = [x]
                     | otherwise = x : c : intersperse c xs


--------------------------------------- ex16
algarismos :: Int -> [Int]
algarismos 0 = []
algarismos n = algarismos (div n 10) ++ [n-(div n 10)*10]


--------------------------------------- ex17
toBits :: Int -> [Int]
toBits x | x < 2 = [x]
         | otherwise = toBits(div x 2) ++ [mod x 2]


----------------------------------------- ex18
fromBits :: [Int] -> Int
fromBits lst = sum ([xi * (2 ^ i) | (xi, i)<-zip lst (reverse [0.. (length lst - 1)])])


--------------------------------------- ex19
mdc :: Integer -> Integer -> Integer
mdc a b | b == 0 = a
        | otherwise = mdc b (mod a b)


-----------------------------------------ex20
-- a)
insert :: Ord a => a -> [a] -> [a]
insert n [] = [n]
insert n (x:xs) = if n < x then n : x : xs
                  else x : insert n xs

-- b)
isort :: Ord a => [a] -> [a]
isort [] = []
isort (x:xs) = insert x (isort xs)


--------------------------------------- ex21
-- a)
minimum' :: Ord a => [a] -> a
minimum' (x:[]) = x
minimum' (x:xs) | and [x < xi | xi<-xs] = x
                | otherwise = minimum' xs
  
-- b)
delete' :: Eq a => a -> [a] -> [a]
delete' elem [] = []
delete' elem (x:xs) | x == elem = xs
                    | otherwise = x : delete' elem xs

-- c)
ssort :: Ord a => [a] -> [a]
ssort [] = []
ssort lst = minimum' lst : ssort (delete' (minimum' lst) lst)


--------------------------------------- ex 22
-- a)
merge' :: Ord a => [a] -> [a] -> [a]
merge' [] y = y
merge' x [] = x
merge' (x:xs) (y:ys) | x <= y = merge' xs (x:y:ys)
                     | otherwise = y : merge' (x:xs) ys

-- b)
msort :: Ord a => [a] -> [a]
msort [] = []
msort (x:[]) = [x]
msort x = merge' (msort (fst half)) (msort (snd half))
    where half = metades x

metades :: [a] -> ([a], [a])
metades x = (take half x, drop half x)
    where half = div (length x) 2


--------------------------------------- ex23
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

