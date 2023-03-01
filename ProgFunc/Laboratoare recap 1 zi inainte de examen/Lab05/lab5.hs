import Data.Char

ex1 :: [Int] -> Int
ex1 l = foldr (+) 0 (map (^2) (filter odd l))

ex2 :: [Bool] -> Bool
ex2 l = foldr (&&) True l

allVerifies :: (Int -> Bool) -> [Int] -> Bool
allVerifies f l = foldr (\x y -> (f x) && y) True l

anyVerifies :: (Int -> Bool) -> [Int] -> Bool
anyVerifies f l = foldr (\x y -> (f x) || y) False l

mapFoldr :: (a -> b) -> [a] -> [b]
mapFoldr f l = foldr (\x y -> [(f x)] ++ y) [] l

filterFoldr :: (a -> Bool) -> [a] -> [a]
filterFoldr f l = foldr (\x y -> if (f x) then [x] ++ y else y) [] l

listToInt :: [Integer] -> Integer
listToInt l = foldl (\x y -> x * 10 + y) 0 l

rmChar :: Char -> String -> String
rmChar ch l = [x | x <- l, x /= ch]

rmCharsRec :: String -> String -> String
rmCharsRec [] l = l
rmCharsRec (x:xs) l = rmCharsRec xs (rmChar x l)

rmCharsFold :: String -> String -> String
rmCharsFold chs l = foldr (\x y -> rmChar x y) l chs
