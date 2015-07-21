TwoRooms.CardsRoute = Ember.Route.extend({
	model: function() {
		return $.getJSON("/cards.json");
	}
});