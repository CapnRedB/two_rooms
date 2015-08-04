TwoRooms.GameRoute = TwoRooms.AuthenticatedRoute.extend({
	model: function(params) {
		this.store.unloadAll('game_player');
		return this.store.findRecord('game', params['game_id']);
	},
	setupController: function(controller, model) {
		controller.set('model', model);

		var self = this;
		this.set('interval', window.setInterval(function(){
			self.refresh();
		}, this.get('duration')));
	},


	duration: 10000,
	interval: null,
	
	actions: {
		refresh : function(){
			console.log("refresh");
			this.refresh();
		}
	}
})