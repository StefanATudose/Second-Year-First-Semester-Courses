{-
class Functor f where
fmap : : ( a -> b ) -> f a -> f b
-}
newtype Identity a = Identity a
instance Functor Identity where
  fmap :: (a -> b) -> Identity a -> Identity b
  fmap f (Identity a) = Identity (f a)

data Pair a = Pair a a
instance Functor Pair where
  fmap :: (a -> b) -> Pair a -> Pair b
  fmap f (Pair a b) = Pair (f a) (f b)

data Constant a b = Constant b
instance Functor (Constant a) where
  fmap f (Constant b) = Constant (f b)

data Two a b = Two a b
instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

data Three a b c = Three a b c
instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

data Three' a b = Three' a b b
instance Functor (Three' a) where
  fmap f (Three' a b c) = Three' a (f b) (f c)

data Four a b c d = Four a b c d
instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

data Four'' a b = Four'' a a a b
instance Functor (Four'' a) where
  fmap f (Four'' a aa aaa b) = Four'' a aa aaa (f b)

data Quant a b = Finance | Desk a | Bloor b
instance Functor (Quant a) where
  fmap f (Finance) = Finance
  fmap f (Desk a) = Desk a
  fmap f (Bloor b) = Bloor (f b)

data LiftItOut f a = LiftItOut (f a)
instance (Functor f) => Functor (LiftItOut f) where
  fmap fun (LiftItOut x) = LiftItOut(fmap fun x)

data Parappa f g a = DaWrappa (f a) (g a)
instance (Functor f, Functor g) => Functor (Parappa f g) where
  fmap fun (DaWrappa x y) = DaWrappa (fmap fun x) (fmap fun y)

data IgnoreOne f g a b = IgnoringSomething (f a) (g b)
instance (Functor g) => Functor (IgnoreOne f g a) where
  fmap fun (IgnoringSomething x y) = IgnoringSomething x (fmap fun y)

data Notorious g o a t = Notorious (g o) (g a) (g t)
instance (Functor g) => Functor (Notorious g o a) where
  fmap fun (Notorious a b c) = Notorious a b (fmap fun c)

data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
instance Functor GoatLord where
  fmap fun (NoGoat) = NoGoat
  fmap fun (OneGoat a) = OneGoat (fun a)
  fmap fun (MoreGoats a b c) = MoreGoats (fmap fun a) (fmap fun b) (fmap fun c)

data TalkToMe a = Halt | Print String a | Read (String -> a)
instance Functor TalkToMe where
  fmap fun Halt = Halt
  fmap fun (Print a b) = Print a (fun b)
  fmap fun (Read f) = Read (fun . f)
