TwoRooms.ApplicationRoute = Ember.Route.extend({
	setupController: function(controller, model) {
		this.controllerFor('application').set('position', 'amid');
	}
});