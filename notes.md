
## Use Cases
### Edit Card Pool

A user with admin privileges wants to modify an existing card or add a new card ( or pair or set).

Modify
> User sees typo on Bomber(R) card. Since she has admin role, she is shown the edit card link
> in the card glossary.  She clicks the [edit card] link and is taken to an edit form.  She 
> clicks save and the update is persisted.
Modify (not admin)
> User sees typo on Bomber(R) card. He does not have the admin role, but he has played enough 
> games to have earned the trusted role.  He clicks the report problem on the cards#show screen. 
> He is shown a different form that has a text box to explain the change, followed by the normal 
> card edit form.  He clicks submit and the patch is serialized and placed in a review queue.


### Build Deck

A user wants to build up a deck they would like to try sometime in the future. She clicks the [Decks] link in the navigation and is shown an index view that shows existing decks.  She can fork/copy an existing deck, or build a new one from scratch.  Cards that have been configured with :required cards will bring those cards along with them, but the system will not enforce the requirement.  The user can break the requirement by deleting a card after it was added.

### Set Up Game

A user wants to play a game. He clicks [Play Now] in the navigation and is shown the Games#new screen this screen first has him select a deck.  Then enter nicknames for each of the players

### Distribute Roles
### Time game
### Capture Results
### Login (oauth & native) (with roles)
### Check Stats


## Routes

### Admin
/cards (REST)
/cards/sort
/cards/:card_id/flip

/card_relationships (REST)

/rounds (REST)
/rounds/:round_id/swaps (REST)



* /edits (REST)

### User
* (devise?)

### Public
* /decks (REST)
  /decks/fork
* /games (REST)


## Ember Routes

	/
	/join
	/sign_up
	/sign_in
A	/profile

a	/games
a	/games/new
a	/game/:game_id

	/decks
A	/decks/new
(o)	/deck/:deck_id
Ao	/deck/:deck_id/new
ao	/deck/:deck_id/:deck_card_id

	/cards
	/card/:card_id



## Models
Deck
	user_id:integer
	name:string
	description:text
	bury:boolean


DeckCard
	deck_id:integer
	card_id:integer
	affiliation:string

Rule
	name
	description

RuleValue
	rule_id
	value
	description

Game
	user_id
	deck_id
	type
	status
	outcome

GameRule
	game_id
	rule_id
	value

GamePlayers
	game_id
	user_id
	card_id
	location:string (a|b)
	leader:boolean
	voting_for_id:integer

GameSwap
	game_id:integer
	round_id:integer
	sequence:integer
	a_to_b_id:integer
	b_to_a_id:integer




##Rule Variants
Untimed					It is possible to have rounds without time limits, therefore requiring no timer at all. To do this, after a leader has publicly announced their hostage(s), they may wait in the hallway between rooms for the opposing leader.

Privacy Promise			Some players prefer to have guaranteed privacy whenever doing any card sharing or color sharing. The privacy promise rule variant forces all players to do any card sharing or color sharing in a secluded private area away from the prying eyes of other players. This works really well when playing with any characters that might give away their identity when others witness consensual revealing (e.g. Zombie, Hot Potato, Identity Thief, Body Snatcher, Warewolf, etc.)

Premature Rejection		There are adanced characters that can lose during the first round (e.g. Agoraphobe, Nuclear Tyrant, etc.). Players can find this pretty demoralizing. This variant allows grey characters that lose the game prior to the last round to treat their card as the Gambler. This is an alternative win objective, allowing these players to remain involved in the game to gain some type of redeeming win.