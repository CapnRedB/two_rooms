TwoRooms.JoinRoute = Ember.Route.extend({
	setupController: function(controller, model) {
		this.controllerFor('application').set('position', 'above');
	},	
});
