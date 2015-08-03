TwoRooms.GameIndexController = Ember.Controller.extend({
	actions: {
		leaveGame: function(player) {
			var self = this;

			var is_self = player.get('is_self');
			var name = player.get('name');
			player.destroyRecord().then(function(){
				TwoRooms.NotificationsManager.push('Removed player ' + name, "info");
				if ( is_self )
				{
					self.transitionTo('profile');
				}
				else
				{
					self.send('refresh');
				}
			},function(){
				TwoRooms.NotificationsManager.push("Unable to remove player " + name, "danger");
				self.send('refresh');
			});
		}
	}
})