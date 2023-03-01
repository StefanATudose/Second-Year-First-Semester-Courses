data Punct = Pt [Int]

data Arb = Vid | F Int | N Arb Arb
          deriving Show

class ToFromArb a where
 	    toArb :: a -> Arb
	    fromArb :: Arb -> a

--1. a)
instance Show Punct where
  show (Pt l)
    |  l == [] = "()"
    | otherwise = "(" ++ concat [show(x) ++ "," | x <- init l] ++ show (last l) ++ ")"


-- Pt [1,2,3]
-- (1, 2, 3)

-- Pt []
-- ()
--b)
instance ToFromArb Punct where
  toArb (Pt []) = Vid
  toArb (Pt (x:xs)) =  N (F x) (toArb (Pt xs))
  fromArb Vid = Pt []
  fromArb (F x) = Pt [x]
  fromArb (N st dr) = Pt (st1 ++ dr1)
    where
      Pt st1 = fromArb st
      Pt dr1 = fromArb dr

-- toArb (Pt [1,2,3])
-- N (F 1) (N (F 2) (N (F 3) Vid))
-- fromArb $ N (F 1) (N (F 2) (N (F 3) Vid)) :: Punct
--  (1,2,3)


--2 a)
data Geo a = Square a | Rectangle a a | Circle a
    deriving Show

class GeoOps g where
  perimeter :: (Floating a) => g a -> a
  area :: (Floating a) =>  g a -> a

instance GeoOps Geo where
  perimeter (Square a) = 4 * a
  perimeter (Rectangle a b) = 2 * a + 2 * b
  perimeter (Circle a) = 2 * pi * a
  area (Square a) = a*a
  area (Rectangle a b) = a*b
  area (Circle a) = a * a * pi




--2 b)
instance (Eq x, Floating x) => Eq (Geo x) where
  (Circle a) == (Circle b) = perimeter(Circle a) == perimeter (Circle b)
  (Rectangle a b) == (Rectangle c d) = perimeter(Rectangle a b) == perimeter (Rectangle c d)
  (Square a) == (Square b) = perimeter(Square a) == perimeter (Square b)
  (Circle a) == (Square b) = perimeter (Circle a) == perimeter (Square a)
  (Square a) == (Rectangle b c) = perimeter(Square a) == perimeter(Rectangle b c)
  (Circle a) == (Rectangle b c) = perimeter(Circle a) == perimeter (Rectangle b c)



-- ghci> pi
-- 3.141592653589793
