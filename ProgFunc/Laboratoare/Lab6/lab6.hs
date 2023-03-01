data Fruct
  = Mar String Bool
  | Portocala String Int

ionatanFaraVierme = Mar "Ionatan" False
goldenCuVierme = Mar "Golden Delicious" True
portocalaSicilia10 = Portocala "Sanguinello" 10
listaFructe = [Mar "Ionatan" False,
                Portocala "Sanguinello" 10,
                Portocala "Valencia" 22,
                Mar "Golden Delicious" True,
                Portocala "Sanguinello" 15,
                Portocala "Moro" 12,
                Portocala "Tarocco" 3,
                Portocala "Moro" 12,
                Portocala "Valencia" 2,
                Mar "Golden Delicious" False,
                Mar "Golden" False,
                Mar "Golden" True]

ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Mar _ _) = False
ePortocalaDeSicilia (Portocala x _)
  | elem x ["Tarocco", "Moro", "Sanguinello"] = True
  | otherwise = False

-- ex1 a
test_ePortocalaDeSicilia1 =
    ePortocalaDeSicilia (Portocala "Moro" 12) == True
test_ePortocalaDeSicilia2 =
    ePortocalaDeSicilia (Mar "Ionatan" True) == False

--ex1 b
--incerc 1, prost

nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia [] = 0
nrFeliiSicilia ((Portocala x y):xs)
  | ePortocalaDeSicilia (Portocala x y) = y + nrFeliiSicilia xs
  | otherwise = nrFeliiSicilia xs
nrFeliiSicilia ((Mar x y):xs) = nrFeliiSicilia xs

{-
--incerc 2
prFelii :: Fruct -> Int
prFelii (Portocala x y) = y

nrFeliiSicilia2 :: [Fruct] -> Int
nrFeliiSicilia [] = 0
nrFeliiSicilia (x:xs)
  | ePortocalaDeSicilia x = prFelii x + nrFeliiSicilia xs
  | otherwise = nrFeliiSicilia xs
-}
test_nrFeliiSicilia = nrFeliiSicilia listaFructe == 52


--ex1 c basic

nrMereViermi :: [Fruct] -> Int
nrMereViermi [] = 0
nrMereViermi ((Mar x y):xs)
  | y = 1 + nrMereViermi xs
  | otherwise = nrMereViermi xs
nrMereViermi ((Portocala x y):xs) = nrMereViermi xs

test_nrMereViermi = nrMereViermi listaFructe == 2




type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
    deriving Show

--ex2 a

vorbeste :: Animal -> String
vorbeste (Pisica num) = "Meow!"
vorbeste (Caine num ras) = "Woof!"

--ex2 b
rasa :: Animal -> Maybe String
rasa (Pisica num) = Nothing
rasa (Caine num ras) = Just ras


data Linie = L [Int]
   deriving Show
data Matrice = M [Linie]
   deriving Show


--ex3 a
suml :: Int -> Linie -> Bool
suml n (L list) = if ( n == foldr (+) 0 list)
                    then True
                  else False


verifica :: Matrice -> Int -> Bool
verifica (M mat) n = foldr (&&) True (map (suml n) mat)


test_verif1 = verifica (M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 10 == False
test_verif2 = verifica (M[L[2,20,3], L[4,21], L[2,3,6,8,6], L[8,5,3,9]]) 25 == True

--ex3 b


doarPozN :: Matrice -> Int -> Bool
doarPozN (M []) len = True
doarPozN (M ((L x) :xs) ) len = if (length x == len)
                                    then if (length (filter (>=0) x) == length x)
                                          then True && (doarPozN (M xs) len)
                                          else False
                                         else
                                          doarPozN (M xs) len

testPoz1 = doarPozN (M [L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == True

testPoz2 = doarPozN (M [L[1,2,-3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == False


--ex3c
corect :: Matrice -> Bool
corect (M ((L x):(L xs):xss)) = if (length x == length xs)
                                then True && corect (M((L xs) : xss))
                              else False
corect (M []) = True;
corect (M [l]) = True;

testcorect1 = corect (M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) == False
testcorect2 = corect (M[L[1,2,3], L[4,5,8], L[3,6,8], L[8,5,3]]) == True
