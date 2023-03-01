{- Monada Maybe este definita in GHC.Base

instance Monad Maybe where
  return = Just
  Just va  >>= k   = k va
  Nothing >>= _   = Nothing


instance Applicative Maybe where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)

instance Functor Maybe where
  fmap f ma = pure f <*> ma
-}

pos :: Int -> Bool
pos  x = if (x>=0) then True else False

fct :: Maybe Int ->  Maybe Bool
fct  mx =  mx  >>= (\x -> Just (pos x))

addM :: Maybe Int -> Maybe Int -> Maybe Int
addM Nothing _ = Nothing
addM _ Nothing = Nothing
addM (Just x) (Just y) = Just (x + y)

addM1 :: Maybe Int -> Maybe Int -> Maybe Int
addM1 ma mb = do
    a <- ma
    b <- mb
    return (a + b)


cartesian_product xs ys = xs >>= ( \x -> (ys >>= \y-> return (x,y)))

cartesian_product1 xs ys = do
                    x <- xs
                    y <- ys
                    return (x,y)

prod f xs ys = [f x y | x <- xs, y<-ys]

prod1 f xs ys = do
                x <- xs
                y <- ys
                return (f x y)

myGetLine :: IO String
myGetLine = getChar >>= \x ->
      if x == '\n' then
          return []
      else
          myGetLine >>= \xs -> return (x:xs)

myGetLine1 :: IO String
myGetLine1 = do
                x <- getChar
                if x == '\n' then
                    return []
                else do
                        xs <- myGetLine1
                        return (x:xs)


prelNo noin =  sqrt noin

ioNumber = do
     noin  <- readLn :: IO Float
     putStrLn $ "Intrare\n" ++ (show noin)
     let  noout = prelNo noin
     putStrLn $ "Iesire"
     print noout

ioNumber1 = (readLn :: IO Float) >>= (\noin ->
    putStrLn ("Intrare\n" ++ show noin) >>
    let noout = prelNo noin in
      putStrLn "Iesire" >>
      print noout)

data Person = Person { name :: String, age :: Int }

showPersonN :: Person -> String
showPersonN (Person name age) = "NAME: " ++ name
showPersonA :: Person -> String
showPersonA (Person name age) = "AGE: " ++ (show age)

{-
showPersonN $ Person "ada" 20
"NAME: ada"
showPersonA $ Person "ada" 20
"AGE: 20"
-}

showPerson :: Person -> String
showPerson pers = "(" ++ (showPersonN pers) ++ ", " ++ (showPersonA pers) ++ ")"

{-
showPerson $ Person "ada" 20
"(NAME: ada, AGE: 20)"
-}


newtype Reader env a = Reader { runReader :: env -> a }


instance Monad (Reader env) where
  return x = Reader (\_ -> x)
  ma >>= k = Reader f
    where f env = let a = runReader ma env
                  in  runReader (k a) env



instance Applicative (Reader env) where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor (Reader env) where
  fmap f ma = pure f <*> ma

mshowPersonN ::  Reader Person String
mshowPersonN = Reader(\p -> ("NAME: " ++ name p))
mshowPersonA ::  Reader Person String
mshowPersonA = Reader(\p -> ("AGE: " ++ show (age p)))
mshowPerson ::  Reader Person String
mshowPerson = do
                name <- mshowPersonN
                age <- mshowPersonA
                return ("(" ++ name ++ ", " ++  age ++ ")")
{-
runReader mshowPersonN  $ Person "ada" 20
"NAME:ada"
runReader mshowPersonA  $ Person "ada" 20
"AGE:20"
runReader mshowPerson  $ Person "ada" 20
"(NAME:ada,AGE:20)"
-}
