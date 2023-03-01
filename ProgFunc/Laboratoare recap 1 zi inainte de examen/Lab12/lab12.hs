import Data.Monoid

elem1 :: (Foldable t, Eq a) => a -> t a -> Bool
elem1 x = foldr ((||) . (== x)) False

null1 :: (Foldable t) => t a -> Bool
null1 = foldr (\a b -> False) True

length1 :: (Foldable t) => t a -> Int
length1 = foldr (\a b -> b + 1) 0

toList1 :: (Foldable t) => t a -> [a]
toList1 = foldr (\a b -> a : b) []

fold1 :: (Foldable t, Monoid m) => t m -> m
fold1 = foldMap id

data Constant a b = Constant b
instance Foldable (Constant a) where
    foldr f i (Constant a) = f a i

data Two a b = Two a b
instance Foldable (Two a) where
    foldr f i (Two a b) = f b i

data Three a b c = Three a b c
instance Foldable (Three a b) where
    foldr f i (Three a b c) = f c i


data Three' a b = Three' a b b
instance Foldable (Three' a) where
    foldr f i (Three' a b c) = f b (f c i)

data Four' a b = Four' a b b b
instance Foldable (Four' a) where
    foldr f i (Four' a b c d) = f b (f c (f d i))

data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
instance Foldable GoatLord where
    foldr f i NoGoat = i
    foldr f i (OneGoat a) = f a i
    foldr f i (MoreGoats a b c) = foldr f (foldr f (foldr f i c) b) a
