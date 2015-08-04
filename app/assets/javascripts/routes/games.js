TwoRooms.GamesRoute = TwoRooms.AuthenticatedRoute.extend({

	model: function() {
		return this.store.findAll('game').then(function(games){
			return games.filter(function(g){
				return g.get('is_owned') 												//owned
					|| g.get('players').any(function(p){ return p.get('is_self');});	//or joined
			})
		});
	},

})