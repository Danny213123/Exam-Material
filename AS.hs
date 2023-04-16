module Main where

import Debug.Trace

shuffle :: [Int] -> ([Int], [Int])
shuffle [] = ([], [])
shuffle [x] = ([x], [])
shuffle (x : y : xs) =
  let (deck_1, deck_2) = shuffle xs
   in (x : deck_1, y : deck_2)

score :: Int -> Int
score x = case x of
  1 -> 14
  _ -> x

insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x (y : ys) = if score x > score y then x : y : ys else y : insert x ys

insertionSort :: [Int] -> [Int]
insertionSort [] = []
insertionSort (x : xs) = insert x (insertionSort xs)

war :: ([Int], [Int], [Int]) -> ([Int], [Int], [Int])
war t = do
  let (deck_1, deck_2, bdeck) = t
  if null deck_1 && null deck_2
    then (deck_1, deck_2, bdeck)
    else
      if null deck_1
        then (deck_1, deck_2 ++ insertionSort bdeck, bdeck)
        else
          if null deck_2
            then (deck_1 ++ insertionSort bdeck, deck_2, bdeck)
            else do
              let (p_card : deck_1') = deck_1
                  (e_card : deck_2') = deck_2
                  new_bdeck = bdeck ++ [max p_card e_card, min p_card e_card]
              if null deck_1 && null deck_2
                then (deck_1', deck_2', new_bdeck)
                else
                  if null deck_1
                    then (deck_1', deck_2' ++ insertionSort new_bdeck, new_bdeck)
                    else
                      if null deck_2
                        then (deck_1' ++ insertionSort new_bdeck, deck_2', new_bdeck)
                        else do
                          let (p_card' : deck_1'') = deck_1'
                              (e_card' : deck_2'') = deck_2'
                              new_bdeck' = new_bdeck ++ [max p_card' e_card', min p_card' e_card']
                          if score p_card' > score e_card'
                            then (deck_1'' ++ insertionSort new_bdeck', deck_2'', new_bdeck')
                            else
                              if score e_card' > score p_card'
                                then (deck_1'', deck_2'' ++ insertionSort new_bdeck', new_bdeck')
                                else do
                                  war (deck_1'', deck_2'', new_bdeck')

check_score :: ([Int], [Int], [Int]) -> ([Int], [Int], [Int])
check_score ([], yy', []) = ([], yy', [])
check_score (xx', [], []) = (xx', [], [])
check_score ([], [], z) = ([],[],z)
check_score t = do
      let (x : xx, y : yy, z) = t
      if score x > score y
        then
          let xx' = xx ++ [x, y]; yy' = yy
           in do
                check_score (xx', yy', [])
        else
          if score y > score x
            then
              let yy' = yy ++ [y, x]; xx' = xx
               in do
                    check_score (xx', yy', [])
            else
              let bdeck = [x, y]
               in do
                    let res = war (xx, yy, [x, y])
                    check_score(res)

main = do
  let inputList = [1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13]
  let (deck_1, deck_2) = shuffle inputList
  putStrLn ("Deck 1: " ++ show deck_1)
  putStrLn ("Deck 2: " ++ show deck_2)
  let (d1, d2, d3) = check_score (deck_1, deck_2, [])
  if null d1 && null d2
    then putStrLn (show d3)
  else if null d1
    then putStrLn (show d2)
  else
    putStrLn (show d1)
  
