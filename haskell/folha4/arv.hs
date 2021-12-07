-- TODO: 7, 9, 10, 11, 12


data Arv a = Vazia
           | No a (Arv a) (Arv a)

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
