TwoRooms.DeckEditController = Ember.Controller.extend({
	// card: null,
	// affiliation: null,

	affiliations: [
		{text: "Required - These cards must go in the deck, but they may be buried.", value: "required" },
		{text: "No Bury - Required and may not be buried.  Use for sets like Sniper/Decoy/Target.", value: "no_bury" },
		{text: "If Bury - Required but may be buried.  Use for secondaries like Doctor/Nurse/Engineer/Tinkerer.", value: "if_bury" },
		{text: "Filler - Added in equal amounts to fill the deck up to the player count.", value: "filler" },
		{text: "Parity - Used to balance odd player counts, or even counts for bury decks.", value: "parity" },
	],	
	actions: {
		cancel: function(){
			this.get('model').rollback();
			return true;
		}	
	}
})

//this is also used as DeckNewController