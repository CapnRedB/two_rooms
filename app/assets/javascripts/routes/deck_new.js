TwoRooms.DeckNewRoute = TwoRooms.AuthenticatedRoute.extend({
	model: function(params) {
		var deck = this.modelFor('deck');
		var model = this.store.createRecord("deck_card");
		model.set('deck', deck);
		model.set('affiliation', 'required');
		return model;
	},
	controllerName: 'deckEdit',
	setupController: function(controller, model) {
		controller.set('model', model);
		controller.set('cards', this.store.findAll('card'));
	},
	actions: {
		save: function() {
			var model = this.get('controller').get('content');
			var self = this;
			model.save().then(function(){
				self.transitionTo('deck.index');
				TwoRooms.NotificationsManager.push("Card added to deck.", "success");
			}, function(){
				TwoRooms.NotificationsManager.push("Unable to add card.", "danger");
			})
		},
		cancel: function(){
			this.transitionTo('deck.index');
		}
	}

});

