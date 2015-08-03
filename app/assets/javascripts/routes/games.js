TwoRooms.GamesRoute = TwoRooms.AuthenticatedRoute.extend({

	model: function() {
		return this.store.find('game');
	}
})