module Lab6 (main, DigitalTime (..)) where

main :: IO ()
main = do
    putStrLn "Hello, world!"

{--
    Add your functions for lab 6 below. Function and type signatures are 
    provided below, along with dummy return values.
    Add your code below each signature, but to not modify the types.
       
    Test your code by running 'cabal test' from the lab3 directory.
--}
    
data DigitalTime = DigitalTime (Int, Int, Int)

instance Show DigitalTime where
   show (DigitalTime (h, m, s)) = 
    let hourStr = if h < 10 then "0" ++ show h else show h
        minuteStr = if m < 10 then "0" ++ show m else show m
        secondStr = if s < 10 then "0" ++ show s else show s
    in "<" ++ hourStr ++ ":" ++ minuteStr ++ ":" ++ secondStr ++ ">"

instance Eq DigitalTime where
  (==) (DigitalTime (h1, m1, s1)) (DigitalTime (h2, m2, s2)) =
    h1 == h2 && m1 == m2 && s1 == s2

instance Ord DigitalTime where
  (<=) (DigitalTime (h1, m1, s1)) (DigitalTime (h2, m2, s2))
    | h1 < h2 = True
    | h1 > h2 = False
    | m1 < m2 = True
    | m1 > m2 = False
    | s1 < s2 = True
    | s2 > s1 = False
    | otherwise = False
    
instance Num DigitalTime where
  (+) (DigitalTime (h1, m1, s1)) (DigitalTime (h2, m2, s2)) =
    let
      totalSeconds = s1 + s2
      totalMinutes = m1 + m2 + (totalSeconds `div` 60)
      totalHours = h1 + h2 + (totalMinutes `div` 60)
      seconds = totalSeconds `mod` 60
      minutes = totalMinutes `mod` 60
      hours = totalHours `mod` 12
    in
      DigitalTime (hours, minutes, seconds)

  (-) (DigitalTime (h1, m1, s1)) (DigitalTime (h2, m2, s2)) =
    let
      totalSeconds = s1 - s2
      totalMinutes = m1 - m2 + (totalSeconds `div` 60)
      totalHours = h1 - h2 + (totalMinutes `div` 60)
      seconds = (totalSeconds `mod` 60 + 60) `mod` 60
      minutes = (totalMinutes `mod` 60 + 60) `mod` 60
      hours = (totalHours `mod` 12 + 12) `mod` 12
    in
      DigitalTime (hours, minutes, seconds)

  fromInteger sec =
    let
      totalSeconds = fromInteger sec
      hours = totalSeconds `div` 3600
      minutes = (totalSeconds `mod` 3600) `div` 60
      seconds = totalSeconds `mod` 60
    in
      DigitalTime (hours `mod` 12, minutes, seconds)
