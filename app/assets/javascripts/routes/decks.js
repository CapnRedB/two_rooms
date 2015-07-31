TwoRooms.DecksRoute = Ember.Route.extend({
	model: function() {
		return this.store.all('deck');
//		return $.get("/decks.json");
	},

	actions: {
		deleteDeck: function(deck_id) {
			var self = this;
			this.store.find('deck', deck_id).then(function (deck) {			
				deck.destroyRecord().then(function(){
					self.transitionTo('decks');
					TwoRooms.NotificationsManager.push("Deck deleted.", "success");
				});
			});
		}
	}
})