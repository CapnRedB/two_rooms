TwoRooms.SignInController = Ember.Controller.extend({
	// needs: ["application"],

	email: "",
	password: "",

	actions: {
		submit: function() {
			var data = {
				user: {
					email: this.get("email"),
					password: this.get("password")
				}
			}
			var self = this;
			$.post("/users/sign_in.json", data).then(function(response) {
				localStorage['token'] = response.token;
				localStorage['name'] =response.name;
				localStorage['email'] = response.email;
				localStorage['user_id'] =response.user_id;

				if ( localStorage['afterAuth'] ) {
					self.transitionToRoute(localStorage['afterAuth']);
				}
				else {
					self.transitionToRoute('profile');			
				}
				localStorage.removeItem('afterAuth');

				TwoRooms.NotificationsManager.push("Logged in.", 'success');
			}, function(response) {
				console.log(response.responseJSON.error);
				TwoRooms.NotificationsManager.push(response.responseJSON.error, 'danger');
				return false;
			});
		}
	}
});