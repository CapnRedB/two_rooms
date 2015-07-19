TwoRooms.ProfileRoute = Ember.Route.extend({
	setupController: function(controller, model){
		if (localStorage['token'] == undefined )
		{
			return controller.transitionToRoute('sign_in');
		}
		controller.set("name", localStorage['name']);
	},
});