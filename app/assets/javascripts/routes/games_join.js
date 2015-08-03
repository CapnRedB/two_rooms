TwoRooms.GamesJoinRoute = TwoRooms.AuthenticatedRoute.extend({

	actions: {
		join: function () {
			var code = this.get('controller').get('code');
			var self = this;
			$.ajax('/games/lookup/' + code + ".json").then(function(data){
				var game_id = data['game']['id'];
				self.store.findRecord('game', game_id).then(function(game){
					var player = self.store.createRecord('game_player', {
						user_id: localStorage['user_id'],
						game: game
					});
					player.save().then(function(){
						TwoRooms.NotificationsManager.push("You've joined game #" + game_id, "success");
						return self.transitionTo("game.index", game);					
					}, function(){
						TwoRooms.NotificationsManager.push("Unable to join game # " + game_id, "danger");
						//return self.transitionTo("profile.index");
					});					
				}, function(){
					TwoRooms.NotificationsManager.push("Unable to find game # " + game_id, "danger");

				});
			},function(){
				TwoRooms.NotificationsManager.push("Unable to find game with code " + code, "danger");
				//return self.transitionTo("profile.index");
			});
		}
	}
});