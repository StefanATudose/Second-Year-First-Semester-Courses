--1
factori :: Int -> [Int]
factori x = [y | y <- [1..x], mod x y == 0]

--2
prim :: Int -> Bool         --Cum cu $?
prim x = (length . factori) x == 2

--3
numerePrime :: Int -> [Int]
numerePrime n = [x | x <- [2..n], prim x]


--4
myzip3 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip3 a b c
  | a == [] || b == [] || c == [] = []
  | otherwise
    = (x, y, z) : (myzip3 xa yb zc)
      where
        x:xa = a
        y:yb = b
        z:zc = c
{-
myzip4 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip4 x y z = [a | let salut = x `zip` y in (let salutt = salut `zip` z in a <- salutt)]
-}

--5
firstEl :: [(a, b)] -> [a]
firstEl a = map fst a


--6
sumList :: [[Int]] -> [Int]
sumList lst = map sum lst

--7
prel2 :: [Int] -> [Int]
prel2 lst = map (\x -> if (mod x 2 == 0) then (div x 2) else x * 2) lst

--8
fct8 :: Char -> [String] -> [String]
fct8 a lst = filter (a `elem`) lst

--9
fct9 :: [Int] -> [Int]
fct9 lst = map (\x -> x * x) hehe
  where hehe = filter odd lst

--10
fct10 :: [Int] -> [Int]
fct10 lst = map (\x -> x * x) qtrStagioni
  where
    capriciosa = filter (\(a, b) -> (mod b 2 == 1)) (zip lst [1..])
    qtrStagioni = map fst capriciosa

--11
vocale = "aeiouAEIOU"
numaiVocale :: [String] -> [String]
numaiVocale lst = map (\str -> filter (`elem` vocale) str) lst

--12
mymap :: (a -> b) -> [a] -> [b]
mymap fct [] = []
mymap fct (x:xs) = (fct x):(mymap fct xs)

myfilter :: (a -> Bool) -> [a] -> [a]
myfilter fct [] = []
myfilter fct (x:xs) =
  if (fct x) then x:(myfilter fct xs)
  else myfilter fct xs
