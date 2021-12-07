import Data.List
import Data.Char

-- TODO: 2, 3, 4, 5, 6
-- DUVIDAS: 6

--------------------------------------- ex2
calcPi1, calcPi2 :: Int -> Double

{-calcPi1 n = sum parcelas
  where num = map (*4) [(-1)^i | i<-[0..]]
        denom = [1,3..]
        parcelas = take n (zipWith (/) num denom)-}

{-calcPi2 n = 3 + sum parcelas
  where num = map (*4) [(-1)^i | i<-[0..]]
        denom = zipWith (*) (zipWith (*) [2,4..] [3,5..]) [4,6..]
        parcelas = take n (zipWith (/) num denom)-}

calcPi1 n = sum (take n (zipWith (/) (cycle [4,-4]) [1,3..]))

calcPi2 n = 3 + sum (take n (zipWith f (cycle [4,-4]) [1,3..]))
  where f = (\x y -> x / product [y,y+1,y+2])


--------------------------------------- ex3
{-intercalar :: a -> [a] -> [[a]]
intercalar e lst = [take i lst ++ [e] ++ drop i lst | i<-[0..length lst]]-}

-- usign let inside list comprehension
intercalar :: a -> [a] -> [[a]]
intercalar e lst = [ left ++ [e] ++ right |
    i<-[0..length lst],
    let left = take i lst,
    let right = drop i lst]


--------------------------------------- ex4
-- returns the list with non repeated elements
uniques :: (Eq a) => [[a]] -> [[a]]
uniques [] = []
uniques (x:xs) | elem x xs = uniques xs
               | otherwise = x : uniques xs

{-
perms :: (Eq a) => [a] -> [[a]]
perms [x] = [[x]]
perms lst = uniques (concat [intercalar (lst !! i) lst_ |
  i <- [0..length lst - 1],
  lst_ <- perms (take i lst ++ drop (i+1) lst)])
-}

perms :: [a] -> [[a]]
perms [] = [[]]
perms (x:xs) = concat [intercalar x y | y<-perms xs]


--------------------------------------- ex5
palavras :: String -> [String]
palavras [] = []
palavras str = takeWhile (not.isSpace) str_ : palavras (dropWhile isSpace (dropWhile (not.isSpace) str_))
  where str_ = dropWhile isSpace str

match :: String -> String -> [(Char, Char)]
match [] _ = []
match sentence key = zip word (take lword key_rep) ++ [(' ',' ')] ++
                     match remaining (drop lword key_rep)
  where key_rep = take (length (concat (palavras sentence))) (cycle key)
        word = takeWhile (not.isSpace) sentence
        lword = length word
        remaining = dropWhile (isSpace) (dropWhile (not.isSpace) sentence)

cifrar :: Int -> Char -> Char
cifrar d c = if isSpace c then ' '
             else chr ((mod ((ord c - ord 'A') + d) 26) + ord 'A')

cifraChave :: String -> String -> String
cifraChave sentence key = [cifrar (ord d - ord 'A') c | (c,d)<-(match sentence key)]


--------------------------------------- ex6
factorial :: Integer -> Integer
factorial n = product [1..n]

binom :: Integer -> Integer -> Integer
binom n k = div (factorial n) (factorial k * factorial (n-k))

pascal :: Integer -> [[Integer]]
pascal x = [[binom n k | k <- [0..n]] | n <- [0..x]]
