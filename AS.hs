module Main where

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

insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y : ys) = if x < y then x : y : ys else y : insert x ys

insertionSort :: Ord a => [a] -> [a]
insertionSort [] = []
insertionSort (x : xs) = insert x (insertionSort xs)

war :: ([Int], [Int], [Int]) -> ([Int], [Int], [Int])
war t = do
  let (deck_1, deck_2, bdeck) = t
  if null deck_1 && null deck_2
    then ([], [], insertionSort bdeck)
    else
      if null deck_1
        then ([], deck_2 ++ insertionSort bdeck, [])
        else
          if null deck_2
            then (deck_1 ++ insertionSort bdeck, [], [])
            else do
              let (p_card : deck_1') = deck_1
                  (e_card : deck_2') = deck_2
                  new_bdeck = bdeck ++ [max p_card e_card, min p_card e_card]
              if null deck_1' && null deck_2'
                then ([], [], insertionSort new_bdeck) -- do something
                else
                  if null deck_1'
                    then ([], deck_2 ++ insertionSort bdeck, [])
                  else
                    if null deck_2'
                      then ([], deck_2 ++ insertionSort bdeck, [])
                    else do
                      let (p_card' : deck_1'') = deck_1'
                          (e_card' : deck_2'') = deck_2'
                          new_bdeck' = new_bdeck ++ [max p_card' e_card', min p_card' e_card']
                      if score p_card' > score e_card'
                        then let p_deck = deck_1'' ++ new_bdeck' in (p_deck, deck_2'', [])
                      else
                        if score e_card' > score p_card'
                          then let e_deck = deck_2'' ++ new_bdeck' in (deck_1'', e_deck, [])
                        else
                          war(deck_1'', deck_2'', [])

                            
check_score :: ([Int], [Int], [Int]) -> Int -> IO ()
check_score ([], yy', []) _ = putStrLn (show yy')
check_score (xx', [], []) _ = putStrLn (show xx')
check_score ([], [], z) _ = putStrLn ("fuck" ++ show z)
check_score t count
  | count >= 10 = putStrLn "Maximum number of runs reached."
  | otherwise = do
      putStrLn ("fuck")
      let (x : xx, y : yy, z) = t
      if score x > score y
        then
          let xx' = xx ++ [x, y]; yy' = yy
           in do
                check_score (xx', yy', []) (count + 1)
        else
          if score y > score x
            then
              let yy' = yy ++ [y, x]; xx' = xx
               in do
                    check_score (xx', yy', []) (count + 1)
            else
              let bdeck = [x, y]
               in do
                  let new_t = war(xx, yy, [x, y]) in check_score (new_t) (count + 1)

main = do
  let inputList = [1, 1, 1, 1, 1, 1, 2, 2, 3, 3]
  let (deck_1, deck_2) = shuffle inputList
  putStrLn ("Deck 1: " ++ show deck_1)
  putStrLn ("Deck 2: " ++ show deck_2)
  check_score (deck_1, deck_2, []) 0
