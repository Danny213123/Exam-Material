defmodule War do

  # Get score, checks to see the rank score of a given card
  def get_score(card) do

    if card == 1 do

      14
    else

      card

    end

  end


  # War guard condition for empty deck1 and deck2 in the middle of war
  def war([], [], bdeck) do

    bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

    {[],[],bdeck}

  end

  # War guard condition for when deck2 is empty during war
  def war(deck1, [], bdeck) do

    bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

    deck1 = deck1 ++ bdeck

    {deck1,[],bdeck}

  end

  # War guard condition for when deck1 is empty during war
  def war([], deck2, bdeck) do

    bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

    deck2 = deck2 ++ bdeck

    {[], deck2, bdeck}

  end

  def war(deck1, deck2, bdeck) do

    # If both decks are not empty, nobody wins, return sorted battle deck as result
    if length(deck1) == 0 && length(deck2) == 0 do

       bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

      {[],[],bdeck}

      # If deck1 is empty then sort battle deck and give it all to player 2
      else if (length(deck1) == 0) do

        bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

        deck2 = deck2 ++ bdeck

        {[], deck2, []}

        # If deck2 is empty then sort battle deck and give it all to player 1
        else if (length(deck2) == 0) do

          bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

          deck1 = deck1 ++ bdeck

          {deck1, {}, []}

        else

          p_card = Enum.at(deck1, 0)

          e_card = Enum.at(deck2, 0)

          deck1 = List.delete_at(deck1, 0)

          deck2 = List.delete_at(deck2, 0)

          bdeck = bdeck ++ [p_card, e_card]

          # If both decks are not empty, nobody wins, return sorted battle deck as result
          if length(deck1) == 0 && length(deck2) == 0 do

             bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

            {[],[],bdeck}

            # If deck1 is empty then sort battle deck and give it all to player 2
            else if (length(deck1) == 0) do

              bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

              deck2 = deck2 ++ bdeck

              {[], deck2, []}

              # If deck2 is empty then sort battle deck and give it all to player 1
              else if (length(deck2) == 0) do

                bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

                deck1 = deck1 ++ bdeck

                {deck1, {}, []}

              else

                p_card = Enum.at(deck1, 0)

                e_card = Enum.at(deck2, 0)


                deck1 = List.delete_at(deck1, 0)

                deck2 = List.delete_at(deck2, 0)

                bdeck = bdeck ++ [p_card, e_card]

                # If player card is greater than enemy card, then give cards from battle deck to player 1
                if (get_score(p_card) > get_score(e_card)) do

                  bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

                  deck1 = deck1 ++ bdeck

                  {deck1, deck2, []}

                  # If player card is less than enemey card, then give cards from battle deck to player 2
                  else if (get_score(e_card) > get_score(p_card)) do

                    bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

                    deck2 = deck2 ++ bdeck

                    {deck1, deck2, []}

                    # If both cards are equal, ANOTHER WARRR
                    else if (get_score(e_card) == get_score(p_card)) do

                      bdeck = Enum.sort(bdeck, fn(x, y) -> get_score(x) > get_score(y) end)

                      {deck1, deck2, bdeck} = war(deck1, deck2, bdeck)

                      {deck1, deck2, bdeck}

                    end

                  end

                end

              end

            end

          end

        end

      end

    end

  end

  # Guard condition, if deck2 is empty
  def check_score(deck1, [], bdeck) do
    {deck1, [], bdeck}
  end

  # Guard condition, if deck1 is empty
  def check_score([], deck2, bdeck) do
    {[], deck2, bdeck}
  end

  # Calculate who wins the game
  def check_score(deck1, deck2, bdeck) do

    p_card = Enum.at(deck1, 0)
    e_card = Enum.at(deck2, 0)

    deck1 = List.delete_at(deck1, 0)
    deck2 = List.delete_at(deck2, 0)

    # If player card is greater than enemy card, give both cards to player 1, sorted by rank
    if get_score(p_card) > get_score(e_card) do

      deck1 = deck1 ++ [p_card, e_card]

      # Recursive call
      {deck1, deck2, bdeck} = check_score(deck1, deck2, [])

      {deck1, deck2, bdeck}

      # If player card is less than enemy card, give both cards to player2, sorted by rank
      else if get_score(e_card) > get_score(p_card) do

        deck2 = deck2 ++ [e_card, p_card]

        # Recursive call
        {deck1, deck2, bdeck} = check_score(deck1, deck2, [])

        {deck1, deck2, bdeck}

        # Both cards are equal
        else if get_score(e_card) == get_score(p_card) do

          # WARRR
          {deck1, deck2, bdeck} = war(deck1, deck2, [p_card, e_card])

          check_score(deck1, deck2, bdeck)

        end

      end

    end

  end

  # Deal a given shuffled deck alternatively between 2 players
  def deal(shuf) do

    {deck1, deck2} = Enum.reduce(shuf, {[], []}, fn card, {d1, d2} ->

      # If deck1 is greater than deck2, give card to deck2
      if length(d1) > length(d2) do

        {d1, d2 ++ [card]}

      else

        {d1 ++ [card], d2}

      end

    end)

    deck1 = Enum.reverse(deck1)

    deck2 = Enum.reverse(deck2)

    {deck1, deck2, bdeck} = (check_score(deck1, deck2, []))

    # If deck1 is not empty, player1 wins
    if (length(deck1) != 0) do

      deck1

      # If deck2 is not empty, player2 wins
      else if (length(deck2) != 0) do

        deck2

        else

        # Tie
        bdeck

      end

    end

  end

end
