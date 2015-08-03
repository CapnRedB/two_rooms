TwoRooms.ApplicationRoute = Ember.Route.extend({
	setupController: function(controller, model) {
		controller.set("model", model);
		// controller.set("cards", this.store.find('card'));
		// controller.set("decks", this.store.find('deck'));
		
		this.store.findAll('card');
		this.store.findAll('deck');

		if ( localStorage['token'] != undefined ) {
			controller.set('signedIn', true);
		}
	}
});