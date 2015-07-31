TwoRooms.CardsRoute = Ember.Route.extend({
	model: function() {
		return this.store.all('card');
		// return $.getJSON("/cards.json");
	},

	// setupController: function(controller, model) {
	// 	controller.set("model", this.controllerFor("application").get("cards"));
	// }
});