TwoRooms.AuthenticatedRoute = Ember.Route.extend({

	beforeModel: function() {
		if ( localStorage['token'] == undefined ) {
			localStorage['afterAuth'] = this.routeName;
			TwoRooms.NotificationsManager.push("You must be logged in to do that.", "warning");
			return this.transitionTo('sign_in');
		}
	}

});