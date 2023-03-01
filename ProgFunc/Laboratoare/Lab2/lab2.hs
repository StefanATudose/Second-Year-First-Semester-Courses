

poly2 :: Double ->Double -> Double -> Double -> Double
poly2 a b c x = a * x * x + b * x + c

xor :: Bool -> Bool -> Bool
xor x y
  | (x == True && y == True) = False
  | (x == True && y == False) = True
  | (x == False && y == True) = True
  | (x == False && y == False) = False

eeny :: Integer -> String
eeny x =
        if (even x)
          then "eeny"
          else "meeny"

{-fizzbuzz :: Integer -> String
fizzbuzz x =
              if (mod x 3 == 0)
                then
                      if (mod x 5 == 0)
                        then "FizzBuzz"
                        else "Fizz"
                else
                  if (mod x 5 == 0)
                    then "Buzz"
                    else ""-}

fizzbuzz :: Integer -> String
fizzbuzz x
  | mod x 3 == 0 && mod x 5 /= 0 = "Fizz"
  | mod x 3 /= 0 && mod x 5 == 0 = "Buzz"
  | mod x 3 == 0 && mod x 5 == 0 = "FizzBuzz"
  | otherwise = ""


fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
    | n < 2     = n
    | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)
fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)


tribonacci :: Integer -> Integer
tribonacci n
  | n < 3 = 1
  | n == 3 = 2
  | otherwise = tribonacci (n-1) + tribonacci (n-2) + tribonacci(n-3)

tribonacci2 :: Integer -> Integer
tribonacci2 1 = 1
tribonacci2 2 = 1
tribonacci2 3 = 2
tribonacci2 n = tribonacci2 (n-1) + tribonacci2 (n-2) + tribonacci2(n-3)

binomial :: Integer -> Integer -> Integer
binomial x y
  | y == 0 = 1
  | x == 0 = 0
  | otherwise = binomial (x-1) y + binomial (x-1) (y-1)


verifL :: [Int] -> Bool
verifL [] = True
verifL lista = xor (verifL(xs)) True
          where x:xs = lista

takefinal :: [a] -> Int -> [a]
takefinal list n
  | length list <= n = list
  | otherwise = takefinal xs n
    where x : xs = list

remove :: [a] -> Int -> [a]
remove list n = (take n list ) ++ (drop (n+1) list)


-- semiPareRec [0,2,1,7,8,56,17,18] == [0,1,4,28,9]
semiPareRec :: [Int] -> [Int]
semiPareRec [] = []
semiPareRec (h:t)
 | even h    = h `div` 2 : t'
 | otherwise = t'
 where t' = semiPareRec t

myreplicate :: Integer -> a -> [a]
myreplicate 0 a = []
myreplicate n a = a:(myreplicate (n-1) a)

sumImp :: [Integer] -> Integer
sumImp [] = 0
sumImp list
  | not (even x) = x + sumImp(xs)
  | otherwise = sumImp(xs)
    where x:xs = list

totalLen :: [String] -> Int
totalLen [] = 0
totalLen list
  | head(elem) == 'A' = (length elem) + (totalLen coada)
  | otherwise = totalLen coada
    where elem:coada = list
