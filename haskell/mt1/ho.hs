-- ho-7
sortByCond :: Ord a => [a] -> (a -> a -> Bool) -> [a]
sortByCond [] _ = []
sortByCond (x:xs) f = sortByCond l f ++ [x] ++ sortByCond r f
  where l = [a | a <- xs, f a x]
        r = [a | a <- xs, not (f a x)]

-- ho-8
myFlip :: (a -> b -> c) -> (b -> a -> c)
myFlip f =  (\x y -> f y x)

myFlip' :: (a -> b -> c) -> (b -> a -> c)
myFlip' = (\f x y -> f y x)

-- h0-10
myUncurry :: (a -> b -> c) -> (a, b) -> c
myUncurry = (\f (x,y) -> f x y)

-- h0-14
orderedTriples :: (Ord a) => [(a,a,a)] -> [(a,a,a)]
orderedTriples triples = filter (\(x,y,z) -> (x <= y) && (y <= z)) triples

-- h0-15
myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f (x:xs) = f x : (myMap f xs)

-- ho-16
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter f (x:xs) | f x = x : (myFilter f xs)
                  | otherwise = myFilter f xs

-- ho-17
-- a)
myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile _ [] = []
myTakeWhile f (x:xs) | f x = [x] ++ myTakeWhile f xs
                     | otherwise = []

-- b)
myDropWhile :: (a -> Bool) -> [a] -> [a]
myDropWhile _ [] = []
myDropWhile f (x:xs) | f x = myDropWhile f xs
                     | otherwise = (x:xs)

-- ho-18
-- a)
myAllRec :: (a -> Bool) -> [a] -> Bool
myAllRec _ [] = True
myAllRec f (x:xs) = (f x) && myAllRec f xs

-- b)
myAllMap :: (a -> Bool) -> [a] -> Bool
myAllMap f l = and (map f l)

-- ho-22
isVowel :: Char -> Bool
isVowel c = c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'

countVowels :: [Char] -> Int
countVowels str = length (filter (isVowel) str)

-- ho-32
myMapFold :: (a -> b) -> [a] -> [b]
myMapFold f l = foldr (\x xs -> (f x):xs) [] l

-- ho-33
largePairs :: Int -> [(Int,Int)] -> [(Int,Int)]
largePairs m l = foldr (\(a,b) ls -> if (b+a >= m) then (a,b):ls else ls) [] l

-- ho-35
separateSingleDigits :: [Int] -> ([Int],[Int])
separateSingleDigits l = foldr (\a (l1,l2) -> if (a >= 0 && a < 10) then (a:l1,l2) else (l1,a:l2)) ([],[]) l

-- ho-40
-- a)
myScanrRec :: (a -> b -> b) -> b -> [a] -> [b]
myScanrRec _ z [] = [z]
myScanrRec f z (x:xs) = (f x (head t)):t
  where t = myScanrRec f z xs

-- b)
myScanrFold :: (a -> b -> b) -> b -> [a] -> [b]
myScanrFold f z l = foldr (\x (h:t) -> (f x h):h:t) [z] l
