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
ePortocalaDeSicilia (Portocala str nr) = if (str == "Tarocco" || str == "Moro" || str == "Sanguinello")
                                          then True
                                          else False
ePortocalaDeSicilia (Mar _ _) = False


test_ePortocalaDeSicilia1 =
    ePortocalaDeSicilia (Portocala "Moro" 12) == True
test_ePortocalaDeSicilia2 =
    ePortocalaDeSicilia (Mar "Ionatan" True) == False

nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia [] = 0
nrFeliiSicilia (x:xs)
  | ePortocalaDeSicilia x = let (Portocala str nr) = x in nr + nrFeliiSicilia xs
  | otherwise = nrFeliiSicilia xs

test_nrFeliiSicilia = nrFeliiSicilia listaFructe == 52

nrMereViermi :: [Fruct] -> Int
nrMereViermi [] = 0
nrMereViermi ((Mar soi vierme):xs) = if vierme then 1 + nrMereViermi xs
                                      else nrMereViermi xs
nrMereViermi ((Portocala soi felii):xs) = nrMereViermi xs

test_nrMereViermi = nrMereViermi listaFructe == 2

type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
    deriving Show

vorbeste :: Animal -> String
vorbeste (Caine a b) = "Woof!"
vorbeste (Pisica a) = "Meow!"

rasa :: Animal -> Maybe String
rasa (Caine nume ras)= Just ras
rasa (Pisica nume) = Nothing

data Linie = L [Int]
   deriving Show
data Matrice = M [Linie]
   deriving Show

verifica :: Matrice -> Int -> Bool
verifica (M l) n = foldr (&&) True (map (\x -> let L ll = x in ((==n) . sum) ll) l)


test_verif1 = verifica (M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 10 == False
test_verif2 = verifica (M[L[2,20,3], L[4,21], L[2,3,6,8,6], L[8,5,3,9]]) 25 == True


doarPoz ::Int -> Linie -> Bool
doarPoz n (L l)
  | length l == n = (filter (> 0) l) == l
  | otherwise = True

doarPozN :: Matrice -> Int -> Bool
doarPozN (M mat) n = foldr (&&) True (map (doarPoz n) mat)


testPoz1 = doarPozN (M [L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == True

testPoz2 = doarPozN (M [L[1,2,-3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == False

corect :: Matrice -> Bool
corect (M ((L x):(L xs):xss)) = if length x == length xs
                                  then True && (corect (M xss))
                                else False && (corect (M ((L xs):xss)))
corect (M []) = True
corect (M [l]) = True

testcorect1 = corect (M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) == False
testcorect2 = corect (M[L[1,2,3], L[4,5,8], L[3,6,8], L[8,5,3]]) == True
