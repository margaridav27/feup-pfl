module Set where


data Set a = Empty -- set vazio
           | Node a (Set a) (Set a) -- elemento, subset dos menores, subset dos maiores


empty :: Set a
empty = Empty


member :: Ord a => a -> Set a -> Bool
member x Empty = False
member x (Node y left right) | x == y = True
                             | x > y = member x right
                             | x < y = member x left


insert :: Ord a => a -> Set a -> Set a
insert x Empty = Node x Empty Empty
insert x (Node y left right) | x == y = Node y left right
                             | x > y = Node y left (insert x right)
                             | x < y = Node y (insert x left) right


toList :: Set a -> [a]
toList Empty = []
toList (Node x l r) = toList l ++ [x] ++ toList r


fromList :: Ord a => [a] -> Set a
fromList = foldr insert Empty


union :: Ord a => Set a -> Set a -> Set a
union s Empty = s
union Empty s = s
union s1 s2 = foldl (\s x -> insert x s) s1 (toList s2)


intersection :: Ord a => Set a -> Set a -> Set a
intersection s Empty = Empty
intersection Empty s = Empty
intersection s1 s2 = foldl (\s x -> if (member x s1) then insert x s else s) Empty (toList s2)


difference :: Ord a => Set a -> Set a -> Set a
difference s Empty = Empty
difference Empty s = Empty
difference s1 s2 = foldl (\s x -> if not (member x s2) then insert x s else s) Empty (toList s1)
