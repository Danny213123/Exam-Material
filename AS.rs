/*
    Get score (rank) of card
    @param card: i32
    @return i32 (score)

*/
fn get_score(card: i32) -> i32 {

    // Ace is 14
    if card == 1 {
        return 14

    // Everything else is just the card number
    } else {

        return card

    }

}

/*
    Do war, draws 1 card from each deck, then draws another card from each deck
    to compare. If the cards are equal, then war is called again. If the cards are
    not equal, then the player with the highest card wins the war and gets all
    cards in the war deck (sorted).
    @param deck1: Vec<i32>
    @param deck2: Vec<i32>
    @param bdeck: Vec<i32>
    @return (Vec<i32>, Vec<i32>, Vec<i32>)

*/
fn war(mut deck1: Vec<i32>, mut deck2: Vec<i32>, mut bdeck: Vec<i32>) -> (Vec<i32>, Vec<i32>, Vec<i32>) {
        
    // If both decks are empty, then return the war deck (sorted)
    if deck1.is_empty() && deck2.is_empty() {

        bdeck.sort_by_key(|a| std::cmp::Reverse(get_score(*a)));
        return (deck1, deck2, bdeck);

    // If deck1 is empty, then sort the war deck and add it to deck2
    } else if deck1.is_empty() {

        bdeck.sort_by_key(|a| std::cmp::Reverse(get_score(*a)));
        deck2.extend(bdeck);
        return (deck1, deck2, Vec::new());

    // If deck2 is empty, then sort the war deck and add it to deck1
    } else if deck2.is_empty() {

        bdeck.sort_by_key(|a| std::cmp::Reverse(get_score(*a)));
        deck1.extend(bdeck);
        return (deck1, deck2, Vec::new());

    }

    // Draw 1 card from each deck
    let pcard = deck1.remove(0);
    let ecard = deck2.remove(0);

    // Add the cards to the war deck
    bdeck.push(pcard);
    bdeck.push(ecard);

    // If both decks are empty, then return the war deck (sorted)
    if deck1.is_empty() && deck2.is_empty() {

        bdeck.sort_by_key(|a| std::cmp::Reverse(get_score(*a)));
        return (deck1, deck2, bdeck);

    // If deck1 is empty, then sort the war deck and add it to deck2
    } else if deck1.is_empty() {

        bdeck.sort_by_key(|a| std::cmp::Reverse(get_score(*a)));
        deck2.extend(bdeck);
        return (deck1, deck2, Vec::new());

    // If deck2 is empty, then sort the war deck and add it to deck1
    } else if deck2.is_empty() {

        bdeck.sort_by_key(|a| std::cmp::Reverse(get_score(*a)));
        deck1.extend(bdeck);
        return (deck1, deck2, Vec::new());

    // IF the cards are equal, then another war
    } else {

        // Draw 1 card from each deck
        let pcard = deck1.remove(0);
        let ecard = deck2.remove(0);

        // Add the cards to the war deck
        bdeck.push(pcard);
        bdeck.push(ecard);
        
        // If score of player card is greater than score of enemy card, then
        if get_score(pcard) > get_score(ecard) {

            bdeck.sort_by_key(|a| std::cmp::Reverse(get_score(*a)));
            deck1.extend(bdeck);
            return (deck1, deck2, Vec::new());

        // If score of enemy card is greater than score of player card, then
        } else if get_score(ecard) > get_score(pcard) {

            bdeck.sort_by_key(|a| std::cmp::Reverse(get_score(*a)));
            deck2.extend(bdeck);
            return (deck1, deck2, Vec::new());

        // If the cards are equal, then another war
        } else {

            bdeck.sort_by_key(|a| std::cmp::Reverse(get_score(*a)));
            return war(deck1, deck2, bdeck);

        }

    }

    (deck1, deck2, bdeck)

}

/*
    Check score of cards, if player card is greater than enemy card, then
    player card is added to the bottom of the player deck, and the enemy card
    is added to the bottom of the enemy deck. If the enemy card is greater than
    the player card, then the enemy card is added to the bottom of the enemy
    deck, and the player card is added to the bottom of the player deck. If
    the cards are equal, then war is called.
    @param deck1: Vec<i32>
    @param deck2: Vec<i32>
    @param bdeck: Vec<i32>
    @return (Vec<i32>, Vec<i32>, Vec<i32>)

*/
fn check_score(mut deck1: Vec<i32>, mut deck2: Vec<i32>, mut bdeck: Vec<i32>) -> (Vec<i32>, Vec<i32>, Vec<i32>){

    // While both decks are not empty
    while deck1.len() > 0 && deck2.len() > 0 {
        
        // Draw 1 card from each deck
        let pcard = deck1.get(0).unwrap().clone();
        let ecard = deck2.get(0).unwrap().clone();
        
        // Remove the cards from the decks
        deck1.remove(0);
        deck2.remove(0);

        // If score of player card is greater than score of enemy card, then
        if get_score(pcard) > get_score(ecard) {

            deck1.push(pcard);
            deck1.push(ecard);

        // If score of enemy card is greater than score of player card, then
        } else if get_score(ecard) > get_score(pcard) {

            deck2.push(ecard);
            deck2.push(pcard);

        // If the cards are equal, then another war
        } else {

            bdeck.push(pcard);
            bdeck.push(ecard);
            (deck1, deck2, bdeck) = war(deck1.clone(), deck2.clone(), bdeck.clone());

        }

    }

    (deck1, deck2, bdeck)

}

/*
    Shuffle the deck of cards and deal them to the player and enemy.
    @param deck: Vec<i32>
    @return (Vec<i32>, Vec<i32>, Vec<i32>)

*/
fn shuffle_deck(deck: Vec<i32>) -> (Vec<i32>, Vec<i32>, Vec<i32>){

    let mut deck1 = vec![];
    let mut deck2 = vec![];
    let bdeck = vec![];

    // Shuffle the deck
    for card in deck.iter() {

        if deck1.len() > deck2.len() {

            deck2.push(*card)

        } else {

            deck1.push(*card)

        }

    }

    deck1.reverse();
    deck2.reverse();

    let (deck1, deck2, bdeck) = check_score(deck1, deck2, bdeck);
    (deck1, deck2, bdeck)

}

/*
    Return the deck of the winner.
    @param numbers: &[u8; 52]
    @return [u8; 52]

*/
fn deal(numbers: &[u8; 52]) -> [u8; 52] {
    let mut deck1 = vec![];
    let mut deck2 = vec![];
    let mut bdeck = vec![];

    let i32_vec: Vec<i32> = numbers.iter().map(|&x| x as i32).collect();

    (deck1, deck2, bdeck) = shuffle_deck(i32_vec);

    if deck1.is_empty() && deck2.is_empty() {
        let bdeck_array: [u8; 52] = bdeck.iter().map(|&x| x as u8).collect::<Vec<u8>>().try_into().unwrap();
        bdeck_array
    } else if deck1.is_empty() {
        deck2.extend(bdeck.clone());
        let deck2_array: [u8; 52] = deck2.iter().map(|&x| x as u8).collect::<Vec<u8>>().try_into().unwrap();
        deck2_array
    } else {
        deck1.extend(bdeck.clone());
        let deck1_array: [u8; 52] = deck1.iter().map(|&x| x as u8).collect::<Vec<u8>>().try_into().unwrap();
        deck1_array
    }
}

#[cfg(test)]
#[path = "tests.rs"]
mod tests;
