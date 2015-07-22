TwoRooms.ProfileRoute = TwoRooms.AuthenticatedRoute.extend({
	setupController: function(controller, model) {
		controller.set('name', localStorage['name']);
		controller.set('model', model);
	}
});