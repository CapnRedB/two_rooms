TwoRooms.ProfileRoute = TwoRooms.AuthenticatedRoute.extend({
	beforeModel: function() {
		if ( ! localStorage['name'] ) {
			this.transitionTo("profile.edit");
		}
	},
	setupController: function(controller, model) {
		controller.set('name', localStorage['name']);
		controller.set('model', model);
	}
});