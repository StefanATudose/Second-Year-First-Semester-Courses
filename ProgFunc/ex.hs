functie :: Int -> [Int]
functie x
  | x == 0 = [0]
  | otherwise = (functie (x-1)) ++ [x]

y = "absdfjsldfjlsdijfosdjfoasjidfijg"

mx = [z | (x, z) <- (functie 6) `zip` y]
