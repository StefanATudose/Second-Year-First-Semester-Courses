{-
class Functor f where
     fmap :: (a -> b) -> f a -> f b
class Functor f => Applicative f where
    pure :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b

Just length <*> Just "world"

Just (++" world") <*> Just "hello,"
pure (+) <> Just 3 <> Just 5
pure (+) <> Just 3 <> Nothing
(++) <$> ["ha","heh"] <*> ["?","!"]
-}
data List a = Nil
            | Cons a (List a)
        deriving (Eq, Show)

instance Functor List where
    fmap f Nil = Nil
    fmap f (Cons x xs) = Cons (f x) (fmap f xs)
instance Applicative List where
    pure x = Cons x Nil
    Nil <*> list = Nil
    (Cons f fs) <*> list = concatList l1 l2
        where
            l1 = fmap f list
            l2 = fs <*> list
            concatList Nil l2 = l2
            concatList (Cons x xs) l2 = Cons x (concatList xs l2)

f = Cons (+1) (Cons (*2) Nil)
v = Cons 1 (Cons 2 Nil)
test1 = (f <*> v) == Cons 2 (Cons 3 (Cons 2 (Cons 4 Nil)))

data Cow = Cow {
        name :: String
        , age :: Int
        , weight :: Int
        } deriving (Eq, Show)

noEmpty :: String -> Maybe String
noEmpty str
    | length str == 0 = Nothing
    | otherwise = Just str

noNegative :: Int -> Maybe Int
noNegative x
    | x <= 0 = Nothing
    | otherwise = Just x

test21 = noEmpty "abc" == Just "abc"
test22 = noNegative (-5) == Nothing
test23 = noNegative 5 == Just 5

cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString name age weight
    | noEmpty name == Nothing = Nothing
    | noNegative age == Nothing = Nothing
    | noNegative weight == Nothing = Nothing
    | otherwise = Just (Cow {name, age, weight})

cowFromString2 :: String -> Int -> Int -> Maybe Cow
cowFromString2 name age weight = fmap Cow (noEmpty name) <> (noNegative age) <> (noNegative weight)

test24 = cowFromString2 "Milka" 5 100 == Just (Cow {name = "Milka", age = 5, weight = 100})

newtype Name = Name String deriving (Eq, Show)
newtype Address = Address String deriving (Eq, Show)

data Person = Person Name Address
    deriving (Eq, Show)

validateLength :: Int -> String -> Maybe String
validateLength x str
    | x <= length str = Nothing
    | otherwise = Just str

test31 = validateLength 5 "abc" == Just "abc"

mkName :: String -> Maybe Name
mkName name
    | validateLength 26 name == Nothing = Nothing
    | otherwise = Just (Name name)

mkAddress :: String -> Maybe Address
mkAddress address
    | validateLength 101 address == Nothing = Nothing
    | otherwise = Just (Address address)

test32 = mkName "Gigel" ==  Just (Name "Gigel")
test33 = mkAddress "Str Academiei" ==  Just (Address "Str Academiei")

mkPerson :: String -> String -> Maybe Person
mkPerson name address
    | mkName name == Nothing = Nothing
    | mkAddress address == Nothing = Nothing
    | otherwise = Just (Person (Name name) (Address address))

mkPerson2 :: String -> String -> Maybe Person
mkPerson2 name address = fmap Person (mkName name) <*> (mkAddress address)

test34 = mkPerson2 "Gigel" "Str Academiei" == Just (Person (Name "Gigel") (Address "Str Academiei"))
