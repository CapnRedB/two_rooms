TwoRooms.DecksRoute = Ember.Route.extend({
	// setupController: function(controller, decks) {
	// 	controller.set('model', )
	// }
	model: function() {
		//return this.get("store").find('deck');
		//return this.store.findAll('deck');
		//return  { decks: [{id: 1, name: "Standard", user_name: "Anonymous"}, {id: 2, name: "Basic", user_name: "Joe"}]};
		return $.getJSON("/decks.json");
	}
})