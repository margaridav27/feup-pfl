module Map where


data Map k v = Empty -- map vazio
             | Node k v (Map k v) (Map k v) -- key value and subtrees


empty :: Map k v
empty = Empty


insert :: Ord k => k -> v -> Map k v -> Map k v
insert x v Empty = Node x v Empty Empty
insert x v (Node y u l r) | x == y = Node x v l r -- já existe key - atualiza-se value
                          | x > y = Node y u l (insert x v r) -- é maior - insere à direita
                          | x < y = Node y u (insert x v l) r -- é menor - insere à esquerda


lookupMap :: Ord k => k -> Map k v -> Maybe v
lookupMap x Empty = Nothing -- não existe
lookupMap x (Node y v l r) | x == y = Just v -- encontrou
                        | x > y = lookupMap x r -- é maior - procura à direita
                        | x < y = lookupMap x l -- é menor - procura à esquerda
