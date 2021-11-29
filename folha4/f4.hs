import Data.List
import Data.Char

-- TODO: 2, 3, 4, 5, 6
-- DUVIDAS: 6

--------------------------------------- ex2
calcPi1 :: Int -> Double
calcPi1 n = sum parcelas
  where num = map (*4) [(-1)^i | i<-[0..]]
        denom = [1,3..]
        parcelas = take n (zipWith (/) num denom)

calcPi2 :: Int -> Double
calcPi2 n = 3 + sum parcelas
  where num = map (*4) [(-1)^i | i<-[0..]]
        denom = zipWith (*) (zipWith (*) [2,4..] [3,5..]) [4,6..]
        parcelas = take n (zipWith (/) num denom)


--------------------------------------- ex3
intercalar :: a -> [a] -> [[a]]
intercalar e lst = (e:lst) : [take i lst ++ [e] ++ drop i lst | i<-[1..length lst]]


--------------------------------------- ex4
-- returns the list with non repeated elements
uniques :: (Eq a) => [[a]] -> [[a]]
uniques [] = []
uniques (x:xs) | elem x xs = uniques xs
               | otherwise = x : uniques xs

perms :: (Eq a) => [a] -> [[a]]
perms [x] = [[x]]
perms lst = uniques (concat [intercalar (lst !! i) lst_ |
  i <- [0..length lst - 1],
  lst_ <- perms (take i lst ++ drop (i+1) lst)])


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
