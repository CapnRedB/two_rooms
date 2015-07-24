TwoRooms.OauthRoute = Ember.Route.extend({
	beforeModel: function() {
		var self = this;
		$.get("/users/signed_in.json").then(function(response){
			TwoRooms.NotificationsManager.push("Logged in.", 'success');

			localStorage['token'] = response.token;
			localStorage['name'] = response.name;
			localStorage['email'] = response.email;
			localStorage['user_id'] = response.user_id;

			if ( localStorage['afterAuth'] ) {
				self.transitionTo(localStorage['afterAuth']);
			}
			else {
				self.transitionTo('profile');			
			}
			localStorage.removeItem('afterAuth');

		}, function(){
			TwoRooms.NotificationsManager.push("Login failed, please try again.", "danger");
			self.transitionTo('sign_in');
		});
	}
});
