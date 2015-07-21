TwoRooms.DeckEditController = Ember.Controller.extend({
	card: null,
	affiliation: null,

	affiliations: [
		{text: "Required - These cards must go in the deck, but they may be buried.", value: "required" },
		{text: "No Bury - Required and may not be buried.  Use for sets like Sniper/Decoy/Target.", value: "no_bury" },
		{text: "Filler - Added in equal amounts to fill the deck up to the player count.", value: "filler" },
		{text: "Parity - Used to balance odd player counts, or even counts for bury decks.", value: "parity" },
	],	
	// selectingCard: false,

	actions: {
		submit: function(){
			// this.transitionToRoute('edit_deck_card.cards');
			// var deck = this.store.createRecord('deck', {
			// 	name: this.get("name"),
			// 	description: this.get("description"),
			// 	bury: this.get("bury")
			// });

			var self = this;
			model.save().then(function(){
				self.transitionToRoute('deck', model.deck);
			},function(deck_card){
				console.log("failed to save");
				console.log(deck_card);
			});

		}
	
	}
})