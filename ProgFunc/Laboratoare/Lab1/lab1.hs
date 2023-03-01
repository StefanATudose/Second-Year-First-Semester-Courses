import Data.List

myInt = 5555555555555555555555555555555555555555555555555555555555555555555555555555555555555

double :: Integer -> Integer
double x = x+x * x


--maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y)
               then x
          else y

max3 x y z = let
             u = maxim x y
             in (maxim  u z)

maxim4 :: Integer -> Integer -> Integer -> Integer -> Integer
maxim4 a b c d =
  let x =
          if (a > b)
            then a
            else b
  in
    let y =
            if (c > d)
              then c
              else d
    in
      if (x > y)
        then x
        else y

prob6a :: Integer -> Integer -> Integer
prob6a a b = a*a + b * b

prob6b :: Integer -> [Char]
prob6b a =
  if (mod a 2 == 0)
   then "par"
   else "impar"

prob6c :: Integer -> Integer
prob6c a =
  if (a == 0)
    then 1
    else a * prob6c (a-1)

prob6d :: Integer -> Integer -> [Char]
prob6d a b =
  if (a > 2 * b)
    then "Primul parametru este mai mare decat dublul celui de-al doilea"
    else "Mai mic/egal decat dublu al doilea"

testWhere :: Integer -> Integer
testWhere a = z a + z a + t a * 3
  where
    z a = a * a
    t a = a + a
