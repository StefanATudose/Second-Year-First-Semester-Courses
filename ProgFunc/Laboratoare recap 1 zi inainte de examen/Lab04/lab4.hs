factori :: Int -> [Int]
factori x = [ d | d <- [1..x], mod x d ==0]

prim :: Int -> Bool
prim x
  | length (factori x) == 2 = True
  | otherwise = False

numerePrime :: Int -> [Int]
numerePrime n = [x | x <- [2..n], prim x]


firstEl :: [(a, b)] -> [a]
firstEl l = map fst l

sumList :: [[Int]] -> [Int]
sumList l = map sum l

prel2 :: [Int] -> [Int]
prel2 l = map (\x -> if even x then (div x 2) else (x * 2)) l

ex8 :: Char -> [String] -> [String]
ex8 ch l = filter (ch `elem`) l

ex9 :: [Int] -> [Int]
ex9 l = map (^2) (filter odd l)

ex10 :: [Int] -> [Int]
ex10 l = map (^2) [a | (a, b) <- (zip l [1..]), even b]

vocale = "aeiouAEIOU"
ex11 :: [String] -> [String]
ex11 l = map (\str -> filter (`elem` vocale) str) l

mymap :: (a -> b) -> [a] -> [b]
mymap fct [] = []
mymap fct (x:xs) = (fct x):(mymap fct xs)

myfilter :: (a -> Bool) -> [a] -> [a]
myfilter fct [] = []
myfilter fct (x:xs) =
  if (fct x) then x:(myfilter fct xs)
  else myfilter fct xs
