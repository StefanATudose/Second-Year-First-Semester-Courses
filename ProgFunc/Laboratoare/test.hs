radical :: Float -> [Float]
radical x
  | x >= 0 = [negate (sqrt x), sqrt x]
  | x < 0 = []

solEq2 :: Float -> Float -> Float -> [Float]
solEq2 0 0 c = []
solEq2 0 b c = return ((negate c) / b)
solEq2 a b c = do
  rDelta <- radical (b*b - 4 * a * c)
  return rDelta

radical2 :: Float -> Maybe Float
radical2 x
  | x >= 0 = return (sqrt x)
  | x < 0 = Nothing

solEq3 :: Float -> Float -> Float -> Maybe Float
solEq3 0 0 0 = return 0
solEq3 0 0 c = Nothing
solEq3 0 b c = return ((negate c) / b)
solEq3 a b c = do
  rDelta <- radical2(b * b - 4 * a * c)
  return ((negate b + rDelta) / (2*a))

add :: Int -> Int
add x = x + 2

newtype Sum a  = Sum {getSum :: a} deriving (Eq, Show)
