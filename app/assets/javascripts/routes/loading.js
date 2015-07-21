TwoRooms.LoadingRoute = Ember.Route.extend({
	setupController: function(controller, model){
		var icon = (Math.random() > 0.5) ? "fa-bomb" : "fa-star-o";
		controller.set('icon', icon);
	}
})