{-
class Functor f where
     fmap :: (a -> b) -> f a -> f b
class Functor f => Applicative f where
    pure :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b

Just length <*> Just "world"

Just (++" world") <*> Just "hello,"
pure (+) <*> Just 3 <*> Just 5
pure (+) <*> Just 3 <*> Nothing
(++) <$> ["ha","heh"] <*> ["?","!"]
-}
--1
data List a = Nil
            | Cons a (List a)
        deriving (Eq, Show)

instance Functor List where
    fmap f Nil = Nil
    fmap f (Cons a xs) = Cons (f a) (fmap f xs)
instance Applicative List where
    pure l = Cons l Nil
    (<*>) Nil l = Nil
    (<*>) (Cons f fs) l= concatList l1 l2
      where l1 = fmap f l
            l2 = fs <*> l

concatList :: List a -> List a -> List a
concatList Nil l = l
concatList (Cons a b) l = Cons a (concatList b l)

f = Cons (+1) (Cons (*2) Nil)
v = Cons 1 (Cons 2 Nil)
test1 = (f <*> v) == Cons 2 (Cons 3 (Cons 2 (Cons 4 Nil)))

--2a
data Cow = Cow {
        name :: String
        , age :: Int
        , weight :: Int
        } deriving (Eq, Show)

noEmpty :: String -> Maybe String
noEmpty "" = Nothing
noEmpty x = Just x

noNegative :: Int -> Maybe Int
noNegative x
  | x < 0 = Nothing
  | otherwise = Just x

test21 = noEmpty "abc" == Just "abc"
test22 = noNegative (-5) == Nothing
test23 = noNegative 5 == Just 5

--b
{-}
cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString s i1 i2
  | (noEmpty s) /= Nothing && (noNegative i1) /= Nothing && (noNegative i2) /= Nothing = Just(Cow s i1 i2)
  | otherwise = Nothing
-}
--c
cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString s i1 i2 = (Just Cow) <*> (noEmpty s) <*> (noNegative i1) <*> (noNegative i2)

test24 = cowFromString "Milka" 5 100 == Just (Cow {name = "Milka", age = 5, weight = 100})

--3
newtype Name = Name String deriving (Eq, Show)
newtype Address = Address String deriving (Eq, Show)

data Person = Person Name Address
    deriving (Eq, Show)

validateLength :: Int -> String -> Maybe String
validateLength l str
  | l <= (length str) = Nothing
  | otherwise = Just str

test31 = validateLength 5 "abc" == Just "abc"

mkName :: String -> Maybe Name
mkName str = (Just Name) <*> (validateLength 25 <$> (Just str))

mkAddress :: String -> Maybe Address
mkAddress = undefined

test32 = mkName "Gigel" ==  Just (Name "Gigel")
test33 = mkAddress "Str Academiei" ==  Just (Address "Str Academiei")

mkPerson :: String -> String -> Maybe Person
mkPerson = undefined

test34 = mkPerson "Gigel" "Str Academiei" == Just (Person (Name "Gigel") (Address "Str Academiei"))
