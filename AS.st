'From Pharo10.0.0 of 5 December 2022 [Build information: Pharo-10.0.0+build.536.sha.2314c3f457171dcde477ff6575b578835f1fd519 (64 Bit)] on 23 February 2023 at 3:33:46.766 am'!
Object subclass: #War
	instanceVariableNames: 'deck p_deck e_deck tie'
	classVariableNames: ''
	package: 'War'!
!War commentStamp: 'DannyGuan 2/23/2023 03:32' prior: 0!
By: Danny

The game starts with a shuffled deck of cards. The deck will be passed into your program
already shuffled (details below). The cards are dealt in an alternating fashion to each player,
so that each player has 26 cards.

In each round, both players reveal the top card of their pile. The player with the higher card
(by rank) wins both cards, placing them at the bottom of their pile. Aces are considered
high, meaning the card ranks in ascending order are 2-10, Jack, Queen, King, Ace.
If the revealed cards are tied, there is war!! Each player turns up one card face down
followed by one card face up. The player with the higher face-up card takes both piles (six
cards – the two original cards that were tied, plus the four cards from the war). If the
turned-up cards are again the same rank, each player places another card face down and
turns another card face up. The player with the higher card takes all 10 cards, and so on.
When one player runs out of cards, they are the loser, and the other the winner. If, during a
war, a player runs out of cards, this counts as a loss as well.!


!War methodsFor: 'initialization' stamp: 'DannyGuan 2/23/2023 03:27'!
calculate_score
	"Main game function, pulls 1 card from each player, compares the cards ranks and either one of the player wins or war is declared"
	"scope: p_deck, e_deck"	
	
	| b_pile p_card e_card |
	"Transcript clear."
	self distribute_deck.
	
	"While both players have cards in their deck"
	[ p_deck size > 0 and: [ e_deck size > 0 ] ] whileTrue: [
		b_pile := OrderedCollection new.
		 
		p_card := p_deck first.
		e_card := e_deck first.
		
		p_deck removeFirst.
		e_deck removeFirst.
	
		((self get_score: p_card) > (self get_score: e_card)) ifTrue: [ p_deck addLast: p_card. p_deck addLast: e_card ].
		((self get_score: e_card) > (self get_score: p_card)) ifTrue: [ e_deck addLast: e_card. e_deck addLast: p_card ].
		((self get_score: p_card) = (self get_score: e_card)) ifTrue: [ b_pile addLast: p_card. b_pile addLast: e_card. self war: b_pile ].
	
	 ].
	
	(e_deck notEmpty) ifTrue: [ ^e_deck ].
	(p_deck notEmpty) ifTrue: [ ^p_deck ].
	(tie notEmpty) ifTrue: [ ^tie]! !

!War methodsFor: 'initialization' stamp: 'DannyGuan 2/23/2023 03:31'!
set_deck: entry_deck
	"Main function: Initializes the instance variables and calls the game function"
	"scope: p_deck, e_deck"	
	
	"Setting up the main deck before shuffling"
	deck := entry_deck.
	
	"Player 1 deck"
	p_deck := OrderedCollection new.
	
	"Player 2 Deck"
	e_deck := OrderedCollection new.
	
	"Tie"
	tie := OrderedCollection new.
	
	^ (self calculate_score) asArray
! !


!War methodsFor: 'sorting' stamp: 'DannyGuan 2/23/2023 02:42'!
sort_b_pile: pile
	"Sorts the battle pile based on ranks from Ace being the highest and 2 being the lowest"
	"scope: No instance or class variables"	

	pile sort: [ :a :b | (self get_score: a) > (self get_score: b) ].
	^ pile! !


!War methodsFor: 'as yet unclassified' stamp: 'DannyGuan 2/22/2023 23:13'!
get_score: card
	"Returns the score of the card based on the ranking"
	"scope: No class or instance variables"	

	"Transcript show: card; cr."
	(card >= 2 and: card <= 13) ifTrue: [ ^card ].
	^14! !

!War methodsFor: 'as yet unclassified' stamp: 'DannyGuan 2/23/2023 03:25'!
distribute_deck
	"Distributes the pile of cards alternatively between the 2 players."
	"scope: p_deck, e_deck"	
	| index |
   index := 1.

   deck do: [ :element |(index odd) ifTrue: [ p_deck add: element ] ifFalse: [ e_deck add: element ]. index := index + 1 ].
	p_deck := p_deck reverse.
	e_deck := e_deck reverse.! !

!War methodsFor: 'as yet unclassified' stamp: 'DannyGuan 2/23/2023 03:23'!
war: b_pile
	"The purpose of this function is to handle the war part of the game, 2 cards are drawn from both players onto the battle ground and the pile is sorted before being handed to the winner"
	"scope: instance-variables: e_deck, p_deck, tie"	

	| p_card e_card |

	1 to: 1 do: [ :ele |
		
		"Transcript show: b_pile; cr."
		((p_deck isEmpty) and: (e_deck isEmpty)) ifTrue: [ tie := (self sort_b_pile: b_pile). ^'tie' ].
		(p_deck isEmpty) ifFalse: [ p_card := p_deck first. ] ifTrue: [ e_deck addAll: (self sort_b_pile: b_pile). ^'Player 1 loses' ].
		(e_deck isEmpty) ifFalse: [ e_card := e_deck first. ] ifTrue: [ p_deck addAll: (self sort_b_pile: b_pile). ^'Player 2 loses' ].
		
		p_deck removeFirst.
		e_deck removeFirst.
		
		((self get_score: p_card) > (self get_score: e_card)) ifTrue: [ b_pile addLast: p_card. b_pile addLast: e_card ].
		((self get_score: e_card) > (self get_score: p_card)) ifTrue: [ b_pile addLast: e_card. b_pile addLast: p_card ].
		((self get_score: p_card) = (self get_score: e_card)) ifTrue: [ b_pile addLast: p_card. b_pile addLast: e_card ].
		
		 ].
	
	((p_deck isEmpty) and: (e_deck isEmpty)) ifTrue: [ tie := (self sort_b_pile: b_pile). ^'tie' ].
	(p_deck isEmpty) ifFalse: [ p_card := p_deck first. p_deck removeFirst ] ifTrue: [ e_deck addAll: (self sort_b_pile: b_pile). ^'Player 1 loses' ].
	(e_deck isEmpty) ifFalse: [ e_card := e_deck first. e_deck removeFirst ] ifTrue: [ p_deck addAll: (self sort_b_pile: b_pile). ^'Player 2 loses' ].
	

	"If player card is greater than enemy card, pile goes to player"
	((self get_score: p_card) > (self get_score: e_card)) ifTrue: [ b_pile addLast: p_card. b_pile addLast: e_card. p_deck addAll: (self sort_b_pile: b_pile) ].
	
	"If enemy card is greater than player card, pile goes to enemy"
	((self get_score: e_card) > (self get_score: p_card)) ifTrue: [ b_pile addLast: e_card. b_pile addLast: p_card. e_deck addAll: (self sort_b_pile: b_pile) ].
	
	"If both cards are tied, calls the war function again"
	((self get_score: p_card) = (self get_score: e_card)) ifTrue: [ b_pile addLast: e_card. b_pile addLast: p_card. self war: (self sort_b_pile: b_pile) ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

War class
	instanceVariableNames: ''!

!War class methodsFor: 'instance creation' stamp: 'DannyGuan 2/23/2023 03:31'!
deal: entry_deck
	"Deals the card, calls the instance functions"
	^self new set_deck: entry_deck.! !
