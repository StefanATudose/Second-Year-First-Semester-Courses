data Point = Pt [Int]
              deriving Show

data Arb = Empty | Node Int Arb Arb
            deriving Show

class ToFromArb a where
  toArb :: a -> Arb
  fromArb :: Arb -> a

instance ToFromArb Point where
  toArb (Pt []) = Empty
  toArb (Pt (x:xs)) = Node x (toArb (filter (<x) xs)) (toArb (filter (>=x) xs))
  fromArb Empty = Pt []
  fromArb (Node x st dr) = let Pt st' = fromArb st
                               Pt dr' = fromArb dr
                           in Pt (st ++ [x] ++ dr)

getFromInterval :: Int -> Int -> [Int] -> [Int]
getFromInterval low up l = filter ((>= low) . (<= up)) l

getFromInterval' :: Int -> Int -> [Int] -> [Int]
getFromInterval' low up l = do
  x <- l
  if (x >= low && x <= up) then return x else []

newtype ReaderWriter env a = RW {getRW :: env-> (a,String)}

newtype ReaderWriter env a = RW {getRW :: env-> (a,String)}

instance Monad (ReaderWriter env) where
  return va = RW (\_ -> (va,""))
  ma >>= k = RW f
      where f env = let (va, str1) = getRW ma env
                        (vb, str2)  = getRW (k va) env
                    in (vb, str1 ++ str2)

instance Applicative (ReaderWriter env) where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)

instance Functor (ReaderWriter env) where
  fmap f ma = pure f <*> ma
