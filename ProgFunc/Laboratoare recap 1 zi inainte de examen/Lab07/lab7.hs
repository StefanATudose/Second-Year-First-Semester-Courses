data Expr = Const Int -- integer constant
          | Expr :+: Expr -- addition
          | Expr :*: Expr -- multiplication
           deriving Eq

data Operation = Add | Mult deriving (Eq, Show)

data Tree = Lf Int -- leaf
          | Node Operation Tree Tree -- branch
           deriving (Eq, Show)

instance Show Expr where
  show (Const a) = show a
  show (a :+: b) = (show a) ++ " :+: " ++ (show b)
  show (a :*: b) = (show a) ++ " :*: " ++ (show b)

evalExp :: Expr -> Int
evalExp (Const a) = a
evalExp (a :+: b) = (evalExp a) + evalExp b
evalExp (a :*: b) = (evalExp a) * evalExp b

exp1 = ((Const 2 :*: Const 3) :+: (Const 0 :*: Const 5))
exp2 = (Const 2 :*: (Const 3 :+: Const 4))
exp3 = (Const 4 :+: (Const 3 :*: Const 3))
exp4 = (((Const 1 :*: Const 2) :*: (Const 3 :+: Const 1)) :*: Const 2)
test11 = evalExp exp1 == 6
test12 = evalExp exp2 == 14
test13 = evalExp exp3 == 13
test14 = evalExp exp4 == 16

evalArb :: Tree -> Int
evalArb (Lf a) = a
evalArb (Node Add a b) = evalArb a + evalArb b
evalArb (Node Mult a b) = evalArb a * evalArb b


arb1 = Node Add (Node Mult (Lf 2) (Lf 3)) (Node Mult (Lf 0)(Lf 5))
arb2 = Node Mult (Lf 2) (Node Add (Lf 3)(Lf 4))
arb3 = Node Add (Lf 4) (Node Mult (Lf 3)(Lf 3))
arb4 = Node Mult (Node Mult (Node Mult (Lf 1) (Lf 2)) (Node Add (Lf 3)(Lf 1))) (Lf 2)

test21 = evalArb arb1 == 6
test22 = evalArb arb2 == 14
test23 = evalArb arb3 == 13
test24 = evalArb arb4 == 16


expToArb :: Expr -> Tree
expToArb (Const a) = (Lf a)
expToArb (a :+: b) = (Node Add (expToArb a) (expToArb b))
expToArb (a :*: b) = (Node Mult (expToArb a) (expToArb b))


class Collection c where
  empty :: c key value
  singleton :: key -> value -> c key value
  insert :: Ord key => key -> value -> c key value -> c key value
  clookup :: Ord key => key -> c key value -> Maybe value
  delete :: Ord key => key -> c key value -> c key value
  keys :: c key value -> [key]
  values :: c key value -> [value]
  toList :: c key value -> [(key, value)]
  fromList :: Ord key => [(key,value)] -> c key value
  keys c = [k | (k, v) <- l]
                        where l = toList c
  values c = [v | (k, v) <- l]
                        where l = toList c
  fromList [] = empty
  fromList (x:xs) = insert k v (fromList xs)
                        where (k, v) = x

newtype PairList k v
  = PairList { getPairList :: [(k, v)] }

instance Collection PairList where
  empty = [()]
  singleton k v = [(k, v)]
  insert k v (PairList l) = PairList ((k v):l)
  clookup k (PairList l) = lookup k l
  delete k (PairList l) = PairList $ (filter ((/= k).fst) l)
  toList l = getPairList l


data SearchTree key value
  = Empty
  | BNode
      (SearchTree key value) -- elemente cu cheia mai mica
      key                    -- cheia elementului
      (Maybe value)          -- valoarea elementului
      (SearchTree key value) -- elemente cu cheia mai mare


      instance Collection SearchTree where
        empty = Empty
        singleton k v = BNode Empty k (Just v) Empty
        insert k v (BNode st k1 v1 dr)
          | k == k1 = BNode st k1 (Just v) dr
          | k < k1 = BNode (insert k v st) k1 v1 dr
          | k > k1 = BNode st k1 v1 (insert k v dr)
        insert k v Empty = singleton k v
        clookup k (BNode st k1 v1 dr)
          | k == k1 = v1
          | k < k1 = clookup k st
          | k > k1 = clookup k dr
        clookup k Empty = Nothing
        delete k (BNode st k1 v1 dr)
          | k == k1 = BNode st k1 Nothing dr
          | k < k1 = BNode (delete k st) k1 v1 dr
          | k > k1 = BNode st k1 v1 (delete k dr)
        delete k Empty = Empty
        toList Empty = []
        toList (BNode st k1 (Just v1) dr) = toList st ++ [(k1, v1)] ++ toList dr
        toList (BNode st k1 Nothing dr) = toList st ++ toList dr

      arb = BNode
            (BNode
                  Empty
                  2
                  (Just 3)
                  Empty
            )
            5
            (Just 1)
            (
            BNode
                  Empty
                  3
                  (Just 5)
                  Empty
            )
