TwoRooms.CardRoute = Ember.Route.extend({
	model: function(params) {
		return this.store.find('card', params.card_id);
	}
});