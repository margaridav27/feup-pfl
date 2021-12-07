-- TODO: 1, 2, 4, 5, 6

import Stack

--------------------------------------- ex1
parent :: String -> Bool
parent str = parentAux str empty

parentAux :: String -> Stack Char -> Bool
parentAux [] stk = isEmpty stk
parentAux (x:xs) stk | x == '(' = parentAux xs (push '(' stk)
                     | x == '[' = parentAux xs (push '[' stk)
                     | x == '{' = parentAux xs (push '{' stk)
                     | x == ')' = not (isEmpty stk) && top stk == '(' && parentAux xs (pop stk)
                     | x == ']' = not (isEmpty stk) && top stk == '[' && parentAux xs (pop stk)
                     | x == '}' = not (isEmpty stk) && top stk == '{' && parentAux xs (pop stk)
                     | otherwise = parentAux xs stk


--------------------------------------- ex2
-- a)
calc :: Stack Float -> String -> Stack Float
calc stk str | str == "+" = push (first + second) stk_
             | str == "-" = push (first - second) stk_
             | str == "*" = push (first * second) stk_
             | str == "/" = push (first / second) stk_
             | otherwise = push (read str) stk
             where first = top stk
                   second = top (pop stk)
                   stk_ = pop (pop stk)

-- b)
calcular :: String -> Float
calcular str = top (foldl (\stk op -> calc stk op) empty (words str))
