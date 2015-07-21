TwoRooms.DeckEditRoute = Ember.Route.extend({
	setupController: function(controller, model) {
		controller.set('cards', this.store.findAll('card'));
		controller.set('model', model);
		// this.store.findAll('card').then(function(cards){
		// 	controller.set('cards', cards); 
		// 	controller.set('card', model.get('card'));
		// 	controller.set('affiliation', model.get('affiliation'));	
		// 	controller.set('model', model);
		// });
	},
	actions: {
		save: function() {
			var model = this.get('controller').get('content');
			var self = this;
			model.save().then(function(){
				//console.log("todo: transition out of the deck.edit")
				self.transitionTo('deck');
			}, function(){
				console.log("deck_card failed to save");
			})
		}
	}

});