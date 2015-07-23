TwoRooms.DeckRoute = Ember.Route.extend({

	setupController: function(controller, model) {
		controller.set('model', model);
		// controller.set('isOwned', model.get('user_id') == localStorage['user_id']);
	},
	actions: {
		deleteDeckCard: function(deck_card_id) {
			var self = this;
			this.store.find('deck_card', deck_card_id).then(function (deck_card) {			
				var deck = deck_card.get('deck');
				deck_card.destroyRecord().then(function(){
					self.transitionTo('deck', deck);
					TwoRooms.NotificationsManager.push("Card removed.", "success");
				});
			});
		}
	}

});