TwoRooms.SignInRoute = Ember.Route.extend({
	beforeModel: function() {
		if ( localStorage['token'] != undefined ) {
			TwoRooms.NotificationsManager.push("You're already Logged in", "info");
			return this.transitionTo('profile');
		}
	}
});