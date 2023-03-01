--1
poly2 :: Double -> Double -> Double -> Double -> Double
poly2 x a b c = a * x ^ 2 + b * x + c

--2
eeny :: Integer -> String
eeny x = case even x of
            True -> "eeny"
            _ -> "meeny"

--3 garzi
fizzbuzz1 :: Integer -> String
fizzbuzz1 x
  | (mod x 15) == 0 = "FizzBuzz"
  | (mod x 5) == 0 = "Buzz"
  | (mod x 3) == 0 = "Fizz"
  | otherwise = ""

--3 if
fizzbuzz2 :: Integer -> String
fizzbuzz2 x = if (mod x 3) == 0
                then if (mod x 5) == 0
                  then "FizzBuzz"
                  else "Fizz"
                else if (mod x 5) == 0
                  then "Buzz"
                  else ""



fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
    | n < 2     = n
    | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)


fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)

--4 cazuri
tribonacci :: Integer -> Integer
tribonacci x
  | x < 3 = 1
  | x == 3 = 2
  | otherwise = (tribonacci x - 1) + (tribonacci x - 2) + (tribonacci x - 3)

--4 ecuational
tribonacci1 :: Integer -> Integer
tribonacci1 1 = 1
tribonacci1 2 = 1
tribonacci1 3 = 2
tribonacci1 x = (tribonacci1 x - 1) + (tribonacci1 x - 2) + (tribonacci1 x - 3)

--5
binomial :: Integer -> Integer -> Integer
binomial n 0 = 1
binomial 0 k = 0
binomial n k = (binomial (n-1) k) + (binomial (n-1) (k-1))

--6a
verifL :: [Int] -> Bool
verifL l = (even . length) l

--b
takefinal :: [Int] -> Int -> [Int]
takefinal lista n =  if (length lista) >= n then (reverse . (take n) . reverse) lista
                      else lista

--c
remove :: [Int] -> Int -> [Int]
remove l n = (take n l) ++ (reverse . take ((length l) - n - 1) . reverse) l

-- semiPareRec [0,2,1,7,8,56,17,18] == [0,1,4,28,9]
semiPareRec :: [Int] -> [Int]
semiPareRec [] = []
semiPareRec (h:t)
 | even h    = h `div` 2 : t'
 | otherwise = t'
 where t' = semiPareRec t

--7 a
myreplicate :: Int -> a -> [a]
myreplicate 1 a = [a]
myreplicate x a =  a:(myreplicate (x-1) a)

--b
sumImp :: [Int] -> Int
sumImp [] = 0
sumImp (x:xs)
  | even x == False = x + (sumImp xs)
  |otherwise = sumImp xs

totalLen :: [String] -> Int
totalLen [] = 0
totalLen (x:xs)
  | head x == 'A' = (length x) + (totalLen xs)
  | otherwise = totalLen xs
