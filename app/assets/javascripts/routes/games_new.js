TwoRooms.GamesNewRoute = TwoRooms.AuthenticatedRoute.extend({
	model: function() {
		var model = this.store.createRecord("game");
		model.set('user_id', localStorage['user_id']);
		return model;
	},
	setupController: function(controller, model) {
		controller.set('model', model);
		controller.set('decks', this.store.all('deck'));
	},
	actions: {
		create: function() {
			var model = this.get('controller').get('content');
			var self = this;
			model.save().then(function(){
				self.transitionTo('game.index', model);
				TwoRooms.NotificationsManager.push("New Game created.", "success");
			}, function(){
				TwoRooms.NotificationsManager.push("Unable to create game.", "danger");
			})
		},

	}
})