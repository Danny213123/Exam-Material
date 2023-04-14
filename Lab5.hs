module Lab5 (main, third_last, every_other, is_cyclops, domino_cycle, tukeys_ninther) where

main :: IO ()
main = do
    putStrLn "Hello, world!"

{--
    Add your functions for lab 3 below. Function and type signatures are 
    provided below, along with dummy return values.
    Add your code below each signature, but to not modify the types.
       
    Test your code by running 'cabal test' from the lab3 directory.
--}
    
third_last :: [a] -> a
third_last (x:_:_:[]) = x 
third_last (_:xs) = third_last xs

every_other :: [a] -> [a]
every_other [] = []
every_other [x] = [x]
every_other (x:_:xs) = x : every_other xs

is_cyclops :: Int -> Bool
is_cyclops num = cyclops_helper(show num)

cyclops_helper :: String -> Bool
cyclops_helper str = odd (length str) && countZeroes == 1
  where middleDigit = str !! (length str `div` 2)
        countZeroes = length(filter(== '0') str)

domino_cycle :: [(Int, Int)] -> Bool
domino_cycle cur_tuple = and [snd x == fst y | (x, y) <- zip cur_tuple (tail (cycle cur_tuple))]

tukeys_ninther :: (Ord a, Num a) => [a] -> a
tukeys_ninther [x] = x
tukeys_ninther items = tukeys_ninther medians
  where
    chunks = [(items !! i, items !! (i+1), items !! (i+2)) | i <- [0,3..length items - 3]]
    medians = [m | (m,_,_) <- chunks] ++ [tukeys_ninther [c | (_,b,c) <- chunks]]

