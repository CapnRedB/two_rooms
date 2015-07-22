TwoRooms.DeckIndexRoute = Ember.Route.extend({

	setupController: function(controller, model) {
		controller.set('model', model);
		controller.set('isOwned', model.user_id == localStorage['user_id']);
	}

});