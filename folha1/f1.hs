-- TODO: 1, 3, 4, 6, 7, 8, 9, 12, 14, 15, 16

--------------------------------------- ex1
testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c = a < b+c && b < a+c && c < a+b


--------------------------------------- ex2
areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt(s*(s-a)*(s-b)*(s-c))
    where s = (a+b+c)/2


--------------------------------------- ex3
metades :: [a] -> ([a],[a])
metades lst = (take half lst, drop half lst)
    where half = div (length lst) 2


--------------------------------------- ex4
lastv1 :: [a] -> a
lastv1 lst = head (reverse lst)

lastv2 :: [a] -> a
lastv2 lst = head (drop (length lst - 1) lst)

initv1 :: [a] -> [a]
initv1 lst = reverse (tail (reverse lst))

initv2 :: [a] -> [a]
initv2 lst = reverse (drop 1 (reverse lst))


--------------------------------------- ex6
raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = (x1, x2)
    where bin = b**2-4*a*c
          x1 = (-b+sqrt(bin))/(2*a)
          x2 = (-b-sqrt(bin))/(2*a)


--------------------------------------- ex7
    -- a) [Char]
    -- b) (Char)
    -- c) [(Bool, Char)]
    -- d) ([Bool], [Char])
    -- e) [[a] -> [a]]
    -- f) [Bool -> Bool] 


--------------------------------------- ex8
    -- a) [a] -> a
    -- b) (a,b) -> (b,a)
    -- c) a -> b -> (a,b)
    -- d) Num a => a -> a
    -- e) Fractional a => a -> a
    -- f) Char -> Bool
    -- g) Ord a => a -> a -> a -> Bool
    -- h) Eq a => [a] -> Bool
    -- i) (a -> a) -> a -> a


--------------------------------------- ex9
{- 
classifica :: Int -> String
classifica grade = msg 
    where msg = if grade <= 9 then "reprovado"
                else if grade >= 10 && grade <= 12 then "suficiente"
                else if grade >= 13 && grade <= 15 then "bom"
                else if grade >= 16 && grade <= 18 then "muito bom"
                else if grade == 19 || grade == 20 then "excelente"
                else "erro" 
-}

classifica :: Int -> String
classifica grade | grade >= 0 && grade <= 9 = "reprovado"
                 | grade >= 10 && grade <= 12 = "suficiente"
                 | grade >= 13 && grade <= 15 = "bom"
                 | grade >= 16 && grade <= 18 = "muito bom"
                 | grade == 19 || grade == 20 = "excelente"
                 | otherwise = "erro"


--------------------------------------- ex12
-- definição de xor
xorv1 :: Bool -> Bool -> Bool
xorv1 a b = (a || b) && (not a || not b) 

-- definição de xor usando múltiplas equações padrão
xorv2 :: Bool -> Bool -> Bool
xorv2 a b | a == b = False
          | otherwise = True


--------------------------------------- ex14
-- usando o prelúdio padrão
curtav1 :: [a] -> Bool
curtav1 lst = length lst >= 0 && length lst <= 2

-- usando múltiplas equações e padrões
curtav2 :: [a] -> Bool
curtav2 lst | length lst == 0 || length lst == 1 || length lst == 2 = True
            | otherwise = False


--------------------------------------- ex15
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = quicksort menores ++ [x] ++ quicksort maiores
    where menores = [y | y<-xs, y<=x]
          maiores = [y | y<-xs, y>x]

mediana :: Ord a => a -> a -> a -> a
mediana x y z = (quicksort [x,y,z]) !! 1


--------------------------------------- ex16
unit :: Int -> String
unit 1 = "um"
unit 2 = "dois"
unit 3 = "tres"
unit 4 = "quatro"
unit 5 = "cinco"
unit 6 = "seis"
unit 7 = "sete"
unit 8 = "oito"
unit 9 = "nove"

teen :: Int -> String
teen 10 = "dez"
teen 11 = "onze"
teen 12 = "doze"
teen 13 = "treize"
teen 14 = "quatorze"
teen 15 = "quinze"
teen 16 = "dezasseis"
teen 17 = "dezassete"
teen 18 = "dezoito"
teen 19 = "dezanove"

ty :: Int -> String
ty 20 = "vinte"
ty 30 = "trinta"
ty 40 = "quarenta"
ty 50 = "cinquenta"
ty 60 = "sessenta"
ty 70 = "setenta"
ty 80 = "oitenta"
ty 90 = "noventa"

hundred :: Int -> String
hundred 100 = "cento"
hundred 200 = "duzentos"
hundred 300 = "trezentos"
hundred 400 = "quatrocentos"
hundred 500 = "quinhentos"
hundred 600 = "seiscentos"
hundred 700 = "setecentos"
hundred 800 = "oitocentos"
hundred 900 = "novecentos"

convert :: Int -> String 
convert n | n == 0 = "zero"
          | n >= 1 && n <= 9 = unit n
          | n >= 10 && n <= 19 = teen n
          | n >= 20 && n <= 90 = if mod n 10 == 0 then ty n
                                 else ty (n - mod n 10) ++ " e " ++ convert (mod n 10)
          | n == 100 = "cem"
          | n > 100 && n < 1000 = if mod n 100 == 0 then hundred n
                                  else hundred (n - mod n 100) ++ " e " ++ convert (mod n 100)
          | n >= 1000 && n < 2000 = if n == 1000 then "mil"
                                    else if mod n 1000 < 100 then "mil e " ++ convert (mod n 1000)
                                    else "mil " ++ convert (mod n 1000)
          | n > 1000 && n < 1000000 = if mod n 1000 == 0 then convert (div n 1000) ++ " mil"
                                      else if mod n 1000 < 100 then convert (div n 1000) ++ " mil e " ++ convert (mod n 1000)
                                      else convert (div n 1000) ++ " mil " ++ convert (mod n 1000)
          | n == 1000000 = "um milhao"
          | otherwise = "invalido" 
