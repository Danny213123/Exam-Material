'From Pharo10.0.0 of 5 December 2022 [Build information: Pharo-10.0.0+build.536.sha.2314c3f457171dcde477ff6575b578835f1fd519 (64 Bit)] on 3 February 2023 at 10:20:04.786 pm'!
Object subclass: #CragRoll
	instanceVariableNames: 'roll'
	classVariableNames: ''
	package: 'CPS506'!

!CragRoll methodsFor: 'accessing' stamp: 'DannyGuan 2/1/2023 11:04'!
setRoll: dice
	roll := dice.
	^self! !

!CragRoll methodsFor: 'accessing' stamp: 'DannyGuan 2/1/2023 11:04'!
getRoll
	^roll! !

!CragRoll methodsFor: 'accessing' stamp: 'DannyGuan 2/3/2023 21:59'!
category
	"Transcript show: 'craig' ; cr."
	(self isCraig = 'IsCraig') ifTrue: [ ^'Craig' ].
	"Transcript show: 'thirteen' ; cr."
	(self isThirteen = 'Thirteen') ifTrue: [ ^'Thirteen' ].
	"Transcript show: 'three' ; cr."
	(self isThreeOfAKind = 'ThreeOfAKind') ifTrue: [ ^'ThreeOfAKind' ].
	"Transcript show: 'straight' ; cr."
	(self isStraight = 'Straight') ifTrue: [ ^'Straight' ].
	
	(self sixes >= 6) ifTrue: [ ^'Sixes' ].
	
	(self fives >= 5) ifTrue: [ ^'Fives' ].
	
	(self fours >= 4) ifTrue: [ ^'Four' ].
	
	(self threes >= 3) ifTrue: [ ^'Three' ].
	
	(self twos >= 2) ifTrue: [ ^'Two' ].
	
	(self ones >= 1) ifTrue: [ ^'One' ].
	
	^'None'! !


!CragRoll methodsFor: 'as yet unclassified' stamp: 'DannyGuan 2/2/2023 16:52'!
threes
	| score |
	score := 0.
	roll do: [ :each | (each = 3) ifTrue: [ score := score + 3]].
	"Transcript show: score; cr."
	^score! !

!CragRoll methodsFor: 'as yet unclassified' stamp: 'DannyGuan 2/2/2023 16:52'!
twos
	| score |
	score := 0.
	roll do: [ :each | (each = 2) ifTrue: [ score := score + 2]].
	"Transcript show: score; cr."
	^score! !

!CragRoll methodsFor: 'as yet unclassified' stamp: 'DannyGuan 2/3/2023 21:59'!
ones
	| score |
	score := 0.
	roll do: [ :each | (each = 1) ifTrue: [ score := score + 1]].
	"Transcript show: score; cr."
	^score! !

!CragRoll methodsFor: 'as yet unclassified' stamp: 'DannyGuan 2/2/2023 16:53'!
fours
	| score |
	score := 0.
	roll do: [ :each | (each = 4) ifTrue: [ score := score + 4]].
	"Transcript show: score; cr."
	^score! !

!CragRoll methodsFor: 'as yet unclassified' stamp: 'DannyGuan 2/2/2023 16:52'!
sixes
	| score |
	score := 0.
	roll do: [ :each | (each = 6) ifTrue: [ score := score + 6]].
	"Transcript show: score; cr."
	^score! !

!CragRoll methodsFor: 'as yet unclassified' stamp: 'DannyGuan 2/2/2023 16:53'!
fives
	| score |
	score := 0.
	roll do: [ :each | (each = 5) ifTrue: [ score := score + 5]].
	"Transcript show: score; cr."
	^score! !


!CragRoll methodsFor: 'testing' stamp: 'DannyGuan 2/3/2023 22:10'!
isCraig
	| total occurences temp_occurences |
	total := roll sum.
	temp_occurences := 0.
	occurences := 0.
	roll do: [ :each | temp_occurences := 0. roll do: [ :else | (else = each) ifTrue: [temp_occurences := temp_occurences + 1]]. occurences := occurences max: temp_occurences. ].
	"Transcript show: occurences; cr."
	(occurences >= 2) & (occurences < 3) & (total = 13) ifTrue: [ ^'IsCraig' ] ifFalse: [ ^'NotCraig' ]
	! !

!CragRoll methodsFor: 'testing' stamp: 'DannyGuan 2/3/2023 22:12'!
isThirteen
	| total |
	total := roll sum.
	(total = 13) ifTrue: [ ^'Thirteen' ].! !

!CragRoll methodsFor: 'testing' stamp: 'DannyGuan 2/1/2023 13:01'!
isThreeOfAKind
	| one two three |
	one := roll at: 1.
	two := roll at: 2.
	three := roll at: 3.
	(one = two) & (one = three) ifTrue: [ ^'ThreeOfAKind' ].! !

!CragRoll methodsFor: 'testing' stamp: 'DannyGuan 2/1/2023 13:07'!
isStraight
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	| one two three |
	one := roll at: 1.
	two := roll at: 2.
	three := roll at: 3.
				
	(one = 1) & (two = 2) & (three = 3) ifTrue: [ ^'Straight' ].
	(one = 4) & (two = 5) & (three = 6) ifTrue: [ ^'Straight' ].
	(one = 1) & (two = 3) & (three = 5) ifTrue: [ ^'Straight' ].
	(one = 2) & (two = 4) & (three = 6) ifTrue: [ ^'Straight' ].! !


!CragRoll methodsFor: 'scoring' stamp: 'DannyGuan 2/2/2023 16:52'!
score
	| category score |
	score := 0.
	category := (self category).
	(category = 'Craig') ifTrue: [ score := 50 max: score ].
	(category = 'Straight') ifTrue: [ score := 20 max: score ].
	(category = 'ThreeOfAKind') ifTrue: [ score := 25 max: score ].
	(category = 'Thirteen') ifTrue: [ score := 26 max: score ].
	score := (self sixes) max: score.
	score := (self fives) max: score.
	score := (self fours) max: score.
	score := (self threes) max: score.
	score := (self twos) max: score.
	score := (self ones) max: score.
	
	^score
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

CragRoll class
	instanceVariableNames: ''!

!CragRoll class methodsFor: 'instance creation' stamp: 'DannyGuan 2/1/2023 11:04'!
new: dice
	"Transcript show: dice."
	^self new setRoll: dice! !


!CragRoll class methodsFor: 'abstract' stamp: 'DannyGuan 2/1/2023 12:53'!
surprise
		| dice |
		dice := Array new: 3.
		dice at: 1 put: (1 to: 6) atRandom.
		dice at: 2 put: (1 to: 6) atRandom.
		dice at: 3 put: (1 to: 6) atRandom.
		^self new: dice! !
