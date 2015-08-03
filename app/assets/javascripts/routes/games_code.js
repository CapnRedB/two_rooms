TwoRooms.GamesCodeRoute = TwoRooms.AuthenticatedRoute.extend({
	model: function(params) {
		var self = this;
		return $.ajax('/games/lookup/' + params["code"] + ".json").then(function(data){
			var game_id = data['game']['id'];
			return self.store.findRecord('game', game_id);
		});
			
		// return this.store.findAll('game').then(function(games){
		// 	return games.filter(function(game){
		// 		return game.get('status') == 'recruiting' && game.get('code') == params["code"];
		// 	}).get('firstObject');
		// });
	},
	afterModel: function(model){
		if ( model )
		{
			var new_player = this.store.createRecord('game_player', {
				game: model,
				user_id: localStorage['user_id'],
				name: localStorage['name']
			});

			new_player.save();
			TwoRooms.NotificationsManager.push("You've joined game #" + model.get('id'), "success");
			return this.transitionTo("game.index", model);
		}
		TwoRooms.NotificationsManager.push("Unable to join game", "danger");
		return this.transitionTo("profile.index");

	},
})