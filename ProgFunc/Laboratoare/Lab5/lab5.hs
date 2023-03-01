--1
ex1 :: [Int] -> Int
ex1 list = sum (map (\x -> x * x) (filter odd list))

--2
ex2 :: [Bool] -> Bool
ex2 list = foldr (&&) True list

--3
allVerifies :: (Int -> Bool) -> [Int] -> Bool
allVerifies fct lst = foldr (&&) True (map fct lst)

--fara map
allVerifies' :: (Int -> Bool) -> [Int] -> Bool
allVerifies' fct lst = foldr (\x y -> (fct x) && y) True lst


--4 fara map
anyVerifies :: (Int -> Bool) -> [Int] -> Bool
anyVerifies fct lst = foldr (\x y -> (fct x) || y) False lst

--5
mapFoldr :: (a -> b) -> [a] -> [b]
mapFoldr fct lst = foldr (\x y -> [(fct x)] ++ y) [] lst

filterFoldr :: (a -> Bool) -> [a] -> [a]
filterFoldr fct lst = foldr (\x y -> if (fct x) then [x] ++ y else y) [] lst

--6
listToInt :: [Integer] -> Integer
listToInt lst = foldl (\x y -> x * 10 + y) 0 lst

--7 a
rmChar :: Char -> String -> String
rmChar chr str = filter (chr /=) str

--b
rmCharsRec :: String -> String -> String
rmCharsRec [] str2 = str2
rmCharsRec (x:xs) str2 = rmCharsRec xs (rmChar x str2)

--c
rmCharsFold :: String -> String -> String
rmCharsFold str1 str2 = foldr (\x y -> (rmChar x y)) str2 str1
