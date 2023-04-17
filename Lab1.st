Part 1:
| sum  total |
sum := 0.
total := 0.
1 to: 10 do: [ :x | (x even) ifTrue: [sum := sum + x. total := total + 1]].
Transcript show: 'The average is: ', (sum / total) asString.

Part 2:
| array unique random_num |
array := OrderedCollection new.
unique := OrderedCollection new.
1 to: 20 do: [ :ele | random_num := (1 to: 15) atRandom. array add: random_num].
Transcript show: 'random: '.
array do: [:each | Transcript show: each; space].
array do: [ :each | (unique includes: each) ifFalse: [ unique add: each ] ].
Transcript show: ''; cr.
Transcript show: 'unique: '.
unique do: [:each | Transcript show: each; space].
Transcript show: ''; cr.
Transcript show: 'Number of unique elements: '.
Transcript show: unique size; cr.

Part 3:
| array random_num largest |
largest := 0.
array := OrderedCollection new.

1 to: (1 to: 100) atRandom do: [ :ele | random_num := (1 to: 10) atRandom. array add: random_num].
1 to: array size do: [ :ele | (ele even) ifFalse: [(ele > largest) ifTrue: [largest := ele ]]].
1 to: array size do: [ :ele | Transcript show: ele; space ].
Transcript show: ''; cr.
Transcript show: largest.
