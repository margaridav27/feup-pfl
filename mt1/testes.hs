import Data.Char
import Data.List

-- TESTE 1 2013

-- ex2
-- a)
countRec :: (a -> Bool) -> [a] -> Int
countRec f [] = 0
countRec f (x:xs) | f x = 1 + countRec f xs
                  | otherwise = countRec f xs

-- b)
count :: (a -> Bool) -> [a] -> Int
count f l = length (filter f l)

-- c)
extras :: String -> Int
extras s = count (not.isLetter) s

-- ex3
split :: Char -> String -> [String]
split c "" = [""]
split c s =  l:(split c r)
  where l = takeWhile (/=c) s
        r = if (dropWhile (/=c) s == "") then ""
            else tail (dropWhile (/=c) s)

-- TESTE 2 2013

-- ex1
-- a)
nodups :: Eq a => [a] -> [a]
nodups [] = []
nodups (x:t) | null t = [x]
             | x==(head t) = nodups t
             | otherwise = x:(nodups t)

-- ex2
{-
Ord a => a -> Arv a -> Arv a
No x Vazia Vazia
No x esq dir
No y (inserir x esq) dir
No y esq (inserir x dir)
-}

-- ex3
data Box = Text String --texto simples
         | Horiz Box Box --justaposição horizontal
         | Vert Box Box --justaposição vertical

alturaBox, larguraBox :: Box -> Int

alturaBox (Text _) = 1
alturaBox (Horiz b1 b2) = max (alturaBox b1) (alturaBox b2)
alturaBox (Vert b1 b2) = 1 + max (alturaBox b1) (alturaBox b2)

larguraBox (Text t) = length t
larguraBox (Horiz b1 b2) = (larguraBox b1) + (larguraBox b2)
larguraBox (Vert b1 b2) = max (larguraBox b1) (larguraBox b2)

-- TESTE 1 2014

-- ex1
-- a)
insert :: Ord a => a -> [a] -> [a]
insert e lst = l ++ [e] ++ r
  where l = takeWhile (<e) lst
        r = dropWhile (<e) lst

-- ex2
data Arv a = Vazia
           | No a (Arv a) (Arv a)

tamanhoArv :: Arv a -> Int
tamanhoArv Vazia = 0
tamanhoArv (No x esq dir) = 1 + tamanhoArv esq + tamanhoArv dir

alturaArv :: Arv a -> Int
alturaArv Vazia = 0
alturaArv (No x esq dir) = 1 + max (alturaArv esq) (alturaArv dir)

-- TESTE 2 2014

-- ex2
myIntersperse :: a -> [a] -> [a]
myIntersperse _ [] = []
myIntersperse _ [x] = [x]
myIntersperse e (x:xs) = x:e:(myIntersperse e xs)

-- ex3
myGroup :: String -> [String]
myGroup "" = []
myGroup (x:xs) = a:b
  where a = x:(takeWhile (==x) xs)
        b = myGroup (dropWhile (==x) xs)

-- TESTE 2016

-- ex1
-- a) [2,3,1,4,4]
-- b) [0,10,20,30,40]
-- c) [[],[3,4],[5]]
-- d) 5
-- e) [1,1,1,1,1,1]
-- f) [(1,4),(2,3),(3,2)]
-- g) [2^i | i<-[0..6]]
-- h) 0
-- i) Num a => [(Bool,a)]
-- j) troca :: (a,b) -> (b,a)
-- k) Num a => a -> a -> a
-- l) [(Int,Int)]

-- ex3
maiores1 :: Ord a => [a] -> [a]
maiores1 (x:xs) | null (x:xs) || null xs = []
                | x > (head xs) = x:(maiores1 xs)
                | otherwise = maiores1 xs

maiores2 :: Ord a => [a] -> [a]
maiores2 l = [x | (x,y)<-zip l (tail l), x>y]

-- ex4
somapares1 :: [(Int, Int)] -> [Int]
somapares1 l = map (\(x,y) -> x+y) l

somapares2 :: [(Int, Int)] -> [Int]
somapares2 = map (uncurry (+))

-- a)
somapares3 :: [(Int, Int)] -> [Int]
somapares3 [] = []
somapares3 (x:xs) = (fst x + snd x):(somapares3 xs)

-- b)
somapares4 :: [(Int, Int)] -> [Int]
somapares4 l = [x+y | (x,y) <- l]

-- ex5
-- a)
itera :: Int -> (a -> a) -> a -> a
itera 0 _ v = v
itera n f v = f (itera (n-1) f v)

-- b)
mult :: Int -> Int -> Int
mult a b = itera a (+b) 0

-- TESTE 2017

-- ex1
-- a) [1,5,4,3]
-- b) [5,6,9]
-- c) 2
-- d) [15..30]
-- e) 4
-- f) [1,2,3,4,6,9]
-- g) [1,2,3]
-- h) [x | x <- concat (transpose [[0,2..10], (map (*(-1)) [1,3..9])])]
      -- ou concat (transpose [[0,2..10], (map (*(-1)) [1,3..9])])
      -- ou [if (mod x 2 == 0) then x else -x | x <- [0..10]]
-- i) 8
-- j) ([Char],[Float])
-- k) (a,b) -> a
-- l) (Ord a, Eq a) => a -> a -> a -> Bool
-- m) [a] -> [a]

-- ex7
{-
crescente :: [Int] -> Bool
crescente [] = False
crescente [a] = True
crescente (x:y:xs) | x > y = False
                   | otherwise = crescente (y:xs)

aux:: Int -> [Int] -> [[Int]]
aux 0 l = [l]
aux v l = [ z | (f,s) <- [(v-x, x) | x<-[1..v], v-x >= 0], z <- (aux f (s:l))]

partes :: Int -> [[Int]]
partes 0 = []
partes x = filter crescente (aux x [])
-}

partesAux :: Int -> [Int] -> [Int] -> [[Int]]
partesAux 0 _ x = [x]
partesAux _ [] _ = []
partesAux n lst@(x:xs) l | n < 0 = []
                         | otherwise = partesAux (n-x) lst (x:l) ++
                                       partesAux n xs l

partes :: Int -> [[Int]]
partes x = map sort (partesAux x [1..x] [])

-- TESTE 2018

-- ex6
decomporAux :: Int -> [Int] -> [Int] -> [[Int]]
decomporAux _ [] _ = []
decomporAux 0 _ change = [change]
decomporAux amount lst@(x:xs) change | amount < 0 = []
                                     | otherwise = decomporAux (amount-x) lst (x:change) ++
                                                   decomporAux amount xs change

decompor :: Int -> [Int] -> [[Int]]
decompor amount lst = decomporAux amount lst []

-- TESTE 2019

-- ex1
-- a) [[1,2],[],[3,4],[5]]
-- b) [5]
-- c) 2
-- d) [16..32]
-- e) [(3,2),(4,3),(5,4),(5,6),(6,8),(7,12)]
-- f) [[2,8],[4,6],[]]
-- g) [(i,j) | (i,j) <- zip [0..6] [6,5..]]
-- h) 1*3 + 3*1 + 1*5 + 5*0 + 0*4 + 4 = 15
-- i) [(Char,String)]
-- j) (Num a, Ord a) => a -> [a] -> Bool
-- k) Eq a => [a] -> Bool
-- l) Eq a => (a -> a) -> a -> Bool

-- ex3
-- a)
diferentes1 :: Ord a => [a] -> [a]
diferentes1 (x:xs) | null (x:xs) || null xs = []
                   | x /= (head xs) = x:(diferentes1 xs)
                   | otherwise = diferentes1 xs

-- b)
diferentes2 :: Eq a => [a] -> [a]
diferentes2 l = [a | (a,b)<-zip l (tail l), a/=b]

-- ex4
myZip3 :: [a] -> [b] -> [c] -> [(a,b,c)]
myZip3 l1 l2 l3 = [(a,b,c) | ((a,b),c) <- zip (zip l1 l2) l3]

-- ex5
partir :: Eq a => a -> [a] -> ([a],[a])
partir x xs = ((takeWhile (/=x) xs),(dropWhile (/=x) xs))

-- ex6
parts:: [a] -> [[[a]]]
parts [] = [[]]
parts (x:xs) = [[x]:ps | ps <- pss] ++ [(x:p):ps | (p:ps) <- pss]
  where pss = parts xs
