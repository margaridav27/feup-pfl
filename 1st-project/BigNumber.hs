module BigNumber(BigNumber, scanner, output, somaBN, subBN, mulBN, divBN, safeDivBN) where
import Data.Char

--BigNumber definition
type BigNumber = (Bool,[Int])

scanner :: String -> BigNumber
scanner str | isDigit(head str) = (True, map digitToInt str)       -- String starts with digit
            | head str == '+' = (True, map digitToInt (tail str))  -- Strings starts with a '+' (positive number)
            | head str == '-' = (False, map digitToInt (tail str)) -- String starts with a '-' (negative number)
            | otherwise = error "Invalid input"                    -- Invalid input


output :: BigNumber -> String
output bn | snd bn == [0] || fst bn = numbers     -- Positive number or 0
          | otherwise = '-' : numbers             -- Negative number
          where numbers = map intToDigit (snd bn)


somaBN, subBN, mulBN :: BigNumber -> BigNumber -> BigNumber

somaBN bn1 bn2 | signal1 == signal2 = (signal1, reverse (auxSoma n1 n2 0)) -- Same signal
               | otherwise          = subBN bn1 (not signal2, snd bn2)     -- Different signals is basically a subtraction
               where n1      = reverse (snd bn1)
                     n2      = reverse (snd bn2)
                     signal1 = fst bn1
                     signal2 = fst bn2


subBN bn1 bn2 | n1 == n2 && signal1 == signal2 = (True, [0])                             -- Symmetric numbers
              | signal1 /= signal2             = somaBN bn1 (not signal2, snd bn2)       -- Different signals is basically a sum
              | maior (snd bn1) (snd bn2)      = (signal1, reverse (auxSub n1 n2 0))     -- Same signal and bn1 greater than bn2
              | otherwise                      = (not signal2, reverse (auxSub n2 n1 0)) -- bn2 greater or equal to bn1
              where n1      = reverse (snd bn1)
                    n2      = reverse (snd bn2)
                    signal1 = fst bn1
                    signal2 = fst bn2


mulBN bn1 bn2 | n1 == [0] || n2 == [0] = (True, [0])                     -- Multiplication by zero
              | signal1 == signal2     = (True, reverse (auxMul n1 n2))  -- Same signal
              | otherwise              = (False, reverse (auxMul n1 n2)) -- Different signals
              where n1      = reverse (snd bn1)
                    n2      = reverse (snd bn2)
                    signal1 = fst bn1
                    signal2 = fst bn2


divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN bn1 bn2 | bn2 == (True, [1]) = (bn1, (True, [0]))                -- Divison by one
              | bn1 == bn2         = ((True, [1]), (True,[0]))         -- Divison by itself
              | maior n1 n2        = ((True, fst res),(True, snd res)) -- bn1 greater than bn2
              | otherwise          = ((True, [0]), bn1)                -- bn2 greater than bn1 (quocient is 0 with bn1 as remainder)
                where n1  = snd bn1
                      n2  = snd bn2
                      res = auxDiv n1 n2 [] []


safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN bn1 (_, [0]) = Nothing              -- Divison by zero
safeDivBN bn1 bn2      = Just (divBN bn1 bn2) -- Divison by a number not zero


-------------------------------- Auxiliary functions --------------------------------

{-
Auxiliary recursive function for sum
Receives:
        - two lists corresponding to the numbers to be summed
        - a parameter to hold the carry that results from the sum
Returns:
        - a list with the result
-}
auxSoma :: [Int] -> [Int] -> Int -> [Int]
auxSoma [] [] carry     = if (carry == 0) then [] else [carry]                       -- sum of 2 empty lists
auxSoma (x:xs) [] carry = [mod (x + carry) 10] ++ auxSoma xs [] (div (x + carry) 10) -- sum of a list with an empty list
auxSoma [] (y:ys) carry = [mod (y + carry) 10] ++ auxSoma [] ys (div (y + carry) 10) -- sum of a list with an empty list
auxSoma (x:xs) (y:ys) carry | res > 9   = [mod res 10] ++ auxSoma xs ys carry_       -- in case the sum of the values exceeds 9
                            | otherwise = [res] ++ auxSoma xs ys 0                   -- save the sum result and continue the operation
                            where res    = x + y + carry
                                  carry_ = div res 10

{-
Auxiliary recursive function for subtraction
Receives:
         - two lists corresponding to the numbers to be subtracted
         - a parameter to hold the carry that resulted from the subtraction
Returns:
         - a list with the result
-}
auxSub :: [Int] -> [Int] -> Int -> [Int]
auxSub [] [] _             = []
auxSub (x:[]) [] carry     = if ((x - carry) == 0) then [] else [x - carry]
auxSub (x:[]) (y:[]) carry = if (x - (y + carry) == 0) then [] else [x - (y + carry)]
auxSub (x:xs) ys carry | res > x   = [x + 10 - res] ++ auxSub xs ys_ 1
                       | otherwise = [x - res] ++ auxSub xs ys_ 0
                       where res = if (ys == []) then carry else (head ys + carry)
                             ys_ = if (ys == []) then [] else (tail ys)

{-
Auxiliary function for multiplication using foldl
Receives:
         - two lists corresponding to the numbers to be multiplied
Returns:
         - a list with the result
This function calls another auxiliar function - scaleBN - responsible for calculating each 'sub-multiplication'
-}
auxMul :: [Int] -> [Int] -> [Int]
auxMul xs ys = foldl (\x (y,i) -> auxSoma x ((take i (repeat 0)) ++ y) 0) [] (zip [scaleBN x ys 0 | x <- xs] [0,1..]) -- sum of the partial results of the scaling operation on the digits in number1 with number2

{-
Auxiliary recursive function for multiplication
Receives:
         - a scalar
         - a list to be scaled
         - a parameter to hold the carry that results from the scaling
Returns:
         - a list with the result
-}
scaleBN :: Int -> [Int] -> Int -> [Int]
scaleBN s [] carry     = if (carry == 0) then [] else [carry]
scaleBN s (x:xs) carry = [res] ++ scaleBN s xs carry_
                         where res    = mod (s * x + carry) 10
                               carry_ = div (s * x + carry) 10

{-
Auxiliary recursive function for division
Receives:-
         - two lists corresponding to the numbers to be divided
         - a list to hold the possible dividend (e.g 250 / 15 - a first possible dividend would be 25, and so on)
         - a list to hold the quotient
Returns:
         - a tuple with the first element as the result and the second as the remainder
This function calls another auxiliar function - subUntil - responsible for calculating each 'sub-division'
-}
auxDiv :: [Int] -> [Int] -> [Int] -> [Int] -> ([Int], [Int])
auxDiv [] _ resto quociente = (dropWhile (==0) quociente, resto)                                                            -- remove the starting zeros from the quocient and return the result
auxDiv (x:xs) divisor dividendo quociente | dividendo_ == divisor    = auxDiv xs divisor [] (quociente ++ [1])              -- new dividendo equals the divisor so there is no remainder and the quocient grows
                                          | maior dividendo_ divisor = auxDiv xs divisor (fst res) (quociente ++ [snd res]) -- new dividendo is greater than divisor so we call the auxiliary subUntil function
                                          | otherwise                = auxDiv xs divisor dividendo_ (quociente ++ [0])      -- we can not divide the current dividendo by the divisor so we keep the division
                                          where dividendo_ = (dropWhile (==0) dividendo) ++ [x]
                                                res        = subUntil dividendo_ divisor 0

{-
Auxiliary recursive function for division
Receives:
         - two lists corresponding to the numbers to be divided
         - a counter to hold the number of times the second argument was subtracted to the first one
Returns:
         - a tuple with the first element as the remainder and the second as the quocient (i.e. the value held by the counter)
This functions acts similarly to the scaleBN function, in the sense that, given a minimal possible dividend and a divisor, it calculates the sub-quocient
-}
subUntil :: [Int] -> [Int] -> Int -> ([Int], Int)
subUntil dividendo divisor i | dividendo == divisor    = ([0], i+1)     -- numbers are the same so the remainder is 0 and the quocient is increased
                             | maior dividendo divisor = subUntil (reverse (auxSub rdividendo rdivisor 0)) divisor (i + 1) -- retry the function after subtraction
                             | otherwise               = (dividendo, i) -- not possible to subtract anymore
                             where rdividendo = (reverse dividendo)
                                   rdivisor   = (reverse divisor)

{-
Auxiliary function that determines if the number represented by the first list is bigger than the number represented by the second
Receives:
         - two lists corresponding to the numbers to be compared
Returns:
         - true if the first one is bigger than the second, false otherwise
-}
maior :: [Int] -> [Int] -> Bool
maior [] [] = False
maior (x:xs) (y:ys) | length (x:xs) > length (y:ys) = True        -- number1 length bigger than number2
                    | length (y:ys) > length (x:xs) = False       -- number2 length bigger than number1
                    | x > y                         = True        -- value in number1 greater than in number2
                    | y > x                         = False       -- value in number2 greater than in number1
                    | otherwise                     = maior xs ys -- retry the function with the rest of the numbers
