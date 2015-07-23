TwoRooms.OauthLinksComponent = Ember.Component.extend({

	actions: {
		oauth: function(provider){
			window.location.replace('/users/auth/' + provider);
		}
	}
});