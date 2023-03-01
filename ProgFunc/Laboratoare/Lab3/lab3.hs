import Data.Char

--Ex1

vocale = "aeiou"

nrVocaleStr :: String -> Int
nrVocaleStr [] = 0
nrVocaleStr list
  | elem h vocale = 1 + nrVocaleStr(t)
  | otherwise = nrVocaleStr(t)
    where h:t = list

nrVocale :: [String] -> Int
nrVocale [] = 0
nrVocale list
  | s == (reverse s) = nrVocaleStr(s) + nrVocale(f)
  | otherwise = nrVocale(f)
      where s:f = list

-- nrVocale ["sos", "civic", "palton", "desen", "aerisirea"] = 9

--Ex2
fEx2 :: Integer -> [Integer] -> [Integer]
fEx2 _ [] = []
fEx2 n list
  | even x = [x, n] ++ (fEx2 n xs)
  | otherwise = [x] ++ (fEx2 n xs)
    where x:xs = list


--Ex3
divizori x = [y | y <- [1..x], mod x y == 0]


--Ex4
listadiv :: [Int] -> [[Int]]
listadiv [] = []
listadiv list =
  let
    x:xs = list
  in
    (divizori x):(listadiv xs)

--Ex5 a)
inIntervalRec :: Integer -> Integer -> [Integer] -> [Integer]
inIntervalRec _ _ [] = []
inIntervalRec sub sup list
  |  sub <= x && x <= sup = [x] ++ (inIntervalRec sub sup xs)
  | otherwise = (inIntervalRec sub sup xs)
    where x:xs = list

--b)
inIntervalComp sub sup list = [x | x <- list, x >= sub, x <= sup]


--Ex6 a)
pozitiveRec :: [Integer] -> Integer
pozitiveRec [] = 0
pozitiveRec list
  | x > 0 = 1 + pozitiveRec xs
  | otherwise = pozitiveRec xs
    where x:xs = list

--b)
pozitiveComp :: [Integer] -> Int
pozitiveComp list = (length [x | x <- list, x > 0])

--Ex7 a)
aflaPoz :: Int -> [Int] -> [Int]
aflaPoz _ [] = []
aflaPoz y list
  | y >= (length list) = []
  | not (even (list !! y)) = y:(aflaPoz (y + 1) list)
  | otherwise = aflaPoz (y + 1) list

pozitiiImpareRec :: [Int] -> [Int]
pozitiiImpareRec [] = []
pozitiiImpareRec list = aflaPoz 0 list


--b)
pozitiiImpareComp list = [x | (x, y) <- [0..] `zip` list, odd y]


--Ex8 a)
cifre = "0123456789"

multDigitsRec :: String -> Int
multDigitsRec [] = 1
multDigitsRec (x:xs)
  | elem x cifre = ((ord x) - 48) * (multDigitsRec xs)
  | otherwise = multDigitsRec xs

--b)
multDigitsComp list = product [(ord x) - 48 | x <- list, elem x cifre]
