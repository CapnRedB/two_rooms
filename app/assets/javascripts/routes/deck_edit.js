TwoRooms.DeckEditRoute = TwoRooms.AuthenticatedRoute.extend({
	setupController: function(controller, model) {
		controller.set('cards', this.store.all('card'));
		controller.set('model', model);
	},
	actions: {
		save: function() {
			var model = this.get('controller').get('content');
			var self = this;
			model.save().then(function(){
				TwoRooms.NotificationsManager.push('Card Saved.', 'success');
				self.transitionTo('deck');
			}, function(){
				TwoRooms.NotificationsManager.push('Unable to save.', 'danger');
			})
		},
		cancel: function(){
			this.transitionTo('deck');
		}
	}

});

