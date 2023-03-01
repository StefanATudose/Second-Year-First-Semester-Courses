import Data.Char
vocale = "aeiouAEIOU"
--1
nrVocCuv :: String -> Int
nrVocCuv [] = 0
nrVocCuv (x:xs)
  | elem x vocale = 1 + nrVocCuv xs
  | otherwise = nrVocCuv xs

nrVocale :: [String] -> Int
nrVocale [] = 0
nrVocale (x:xs)
  | x == (reverse x) = (nrVocCuv x) + nrVocale xs
  | otherwise = nrVocale xs

--2
addElemAfterPar :: Int -> [Int] -> [Int]
addElemAfterPar _ [] = []
addElemAfterPar n (x:xs)
  | even x = [x, n] ++ (addElemAfterPar n xs)
  | otherwise = [x] ++ addElemAfterPar n xs

--3
divizori :: Int -> [Int]
divizori n = [d | d <- [1..n], mod n d == 0]

--4
listadiv :: [Int] -> [[Int]]
listadiv [] = []
listadiv (x:xs) = [d | d <- [1..x], mod x d == 0] : (listadiv xs)

--5
--a
inIntervalRec :: Int -> Int -> [Int] -> [Int]
inIntervalRec _ _ [] = []
inIntervalRec a b (x:xs)
  | (a <= x) && (x <= b) = x : (inIntervalRec a b xs)
  | otherwise = inIntervalRec a b xs

--b
inIntervalComp :: Int -> Int -> [Int] -> [Int]
inIntervalComp a b l = [x | x <- l, a <= x, x<= b]

--6 a
pozitiveRec :: [Int] -> Int
pozitiveRec [] = 0
pozitiveRec (x:xs)
  | x > 0 = x + (pozitiveRec xs)
  | otherwise = pozitiveRec xs

--b
pozitiveComp :: [Int] -> Int
pozitiveComp l = length [x | x <- l, x > 0]

--7
pozitiiImpareComp :: [Int] -> [Int]
pozitiiImpareComp l = [b | (a, b) <- (zip l [0..]), odd a]

--8
multDigitsComp :: String -> Int
multDigitsComp l = product [digitToInt x | x <- l, isDigit x]
