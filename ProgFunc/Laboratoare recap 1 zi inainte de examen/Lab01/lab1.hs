import Data.List

myInt = 5555555555555555555555555555555555555555555555555555555555555555555555555555555555555

double :: Integer -> Integer
double x = x+x

maxim x y = if (x > y)
               then x
          else y

max3 x y z = let
             u = maxim x y
             in (maxim  u z)


sumPow2 :: Int -> Int -> Int
sumPow2 x y = x * x + y * y

isEven :: Int -> String
isEven x = case even x of
            True -> "par"
            _ -> "Impar"

fact :: Int -> Int
fact x
  | x == 0 = 1
  | otherwise = x * (fact (x-1))

verifDubl :: Int -> Int -> Bool
verifDubl x y = x > 2 * y
