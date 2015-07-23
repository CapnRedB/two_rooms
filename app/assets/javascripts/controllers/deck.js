TwoRooms.DeckController = Ember.Controller.extend({
	isOwned: false,

	actions: {
		save: function() {
			var model = this.get('content');
			var self = this;
			model.save().then(function(){
				TwoRooms.NotificationsManager.push('Deck Saved.', 'success');
				self.transitionTo('decks');
			}, function(response){
				var message = response.responseJSON.error;
				TwoRooms.NotificationsManager.push('Unable to save. ' + message, 'danger');
			});
		}
	}
})