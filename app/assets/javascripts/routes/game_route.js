TwoRooms.GameRoute = TwoRooms.AuthenticatedRoute.extend({
	model: function(params) {
		return this.store.findRecord('game', params['game_id']);
	},
	actions: {
		refresh : function(){
			console.log("refresh");
			this.refresh();
		}
	}
})