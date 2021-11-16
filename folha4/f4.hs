import Data.List
import Data.Char

-- TODO: 2, 3, 4, 5, 6, 7, 9, 10, 11, 12
-- DUVIDAS: 6

data Arv a = Vazia | No a (Arv a) (Arv a)

--------------------------------------- ex2
calcPi1, calcPi2 :: Int -> Double
calcPi1 n = sum parcelas
    where num = map (*4) [(-1)^i | i<-[0..]]
          denom = [1,3..]
          parcelas = take n (zipWith (/) num denom)
calcPi2 n = 3 + sum parcelas
    where num = map (*4) [(-1)^i | i<-[0..]]
          denom = zipWith (*) (zipWith (*) [2,4..] [3,5..]) [4,6..]
          parcelas = take n (zipWith (/) num denom)


--------------------------------------- ex5
palavras :: String -> [String]
palavras [] = []
palavras str = [before_space] ++ palavras after_space
    where before_space = takeWhile (\c -> not (isSpace c)) str
          after_space = dropWhile (\c -> isSpace c) (dropWhile (\c -> not (isSpace c)) str)

constructMatch :: String -> String -> [(Char, Char)]
constructMatch [] _ = []
constructMatch sentence key = zip word (take (length word) key_rep) ++
                              [(' ',' ')] ++
                              constructMatch remaining (drop (length word) key_rep)
    where key_rep = take (length (concat (palavras sentence))) (cycle key)
          word = takeWhile (\c -> not (isSpace c)) sentence
          remaining = dropWhile (\c -> isSpace c) (dropWhile (\c -> not (isSpace c)) sentence)

cifrar :: Int -> Char -> Char
cifrar d c = if isSpace c then ' '
             else chr ((mod ((ord c - ord 'A') + d) 26) + ord 'A')

cifraChave :: String -> String -> String
cifraChave sentence key = [cifrar (ord d - ord 'A') c | (c,d)<-(constructMatch sentence key)]


--------------------------------------- ex6
factorial :: Integer -> Integer
factorial n = product [1..n]

binom :: Integer -> Integer -> Integer
binom n k = div (factorial n) (factorial k * factorial (n-k))

pascal :: Integer -> [[Integer]]
pascal x = [[binom n k | k <- [0..n]] | n <- [0..x]]


--------------------------------------- ex7
sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No x esq dir) = x + sumArv esq + sumArv dir


--------------------------------------- ex8
listar :: Arv a -> [a]
listar Vazia = []
listar (No x esq dir) = listar esq ++ [x] ++ listar dir


--------------------------------------- ex9
nivel :: Int -> Arv a -> [a]
nivel _ Vazia = []
nivel 0 (No x esq dir) = [x]
nivel n (No x esq dir) = nivel (n-1) esq ++ nivel (n-1) dir


--------------------------------------- ex10
mapArv :: (a -> b) -> Arv a -> Arv b
mapArv f Vazia = Vazia
mapArv f (No x esq dir) = No (f x) (mapArv f esq) (mapArv f dir)


--------------------------------------- ex11
inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir) | x == y = No y esq dir
                         | x < y = No y (inserir x esq) dir
                         | x > y = No y esq (inserir x dir)

construir :: Ord a => [a] -> Arv a
construir [] = Vazia
construir (x:xs) = inserir x (construir xs)

construirBinPartition :: [a] -> Arv a
construirBinPartition [] = Vazia
construirBinPartition xs = No x (construirBinPartition xs1) (construirBinPartition xs2)
                          where n = div (length xs) 2
                                xs1 = take n xs
                                x:xs2 = drop n xs

calculaAltura :: Arv a -> Int
calculaAltura Vazia = 0
calculaAltura (No x esq dir) = 1 + max (calculaAltura esq) (calculaAltura dir)


--------------------------------------- ex12
-- a)
-- encontra o elemento mais à esquerda - o menor valor
maisEsq :: Arv a -> a
maisEsq (No x Vazia _) = x
maisEsq (No _ esq _) = maisEsq esq

-- encontra o elemento mais à direita - o maior valor
maisDir :: Arv a -> a
maisDir (No x _ Vazia) = x
maisDir (No _ _ dir) = maisDir dir

-- b
-- remove o elemento mais à direita da sub árvore da esquerda
removerEsq :: Ord a => a -> Arv a -> Arv a
removerEsq x Vazia = Vazia
removerEsq x (No y Vazia dir)
  | x == y = dir
removerEsq x (No y esq Vazia)
  | x == y = esq
removerEsq x (No y esq dir)
  | x < y = No y (removerEsq x esq) dir
  | x > y = No y esq (removerEsq x dir)
  | x == y = let z = maisEsq dir
             in No z esq (removerEsq z dir)

-- remove o elemento mais à esquerda da sub árvore da direita
removerDir :: Ord a => a -> Arv a -> Arv a
removerDir x Vazia = Vazia -- não ocorre
removerDir x (No y Vazia dir) -- um descendente
  | x == y = dir
removerDir x (No y esq Vazia) -- um descendente
  | x == y = esq
removerDir x (No y esq dir) -- dois descendentes
  | x < y = No y (removerDir x esq) dir
  | x > y = No y esq (removerDir x dir)
  | x == y = let z = maisDir esq
             in No z (removerDir z esq) dir

-- (No 11 (No 3 (No 2 Vazia Vazia) (No 5 Vazia Vazia)) (No 19 (No 13 Vazia Vazia) (No 23 Vazia Vazia)))
