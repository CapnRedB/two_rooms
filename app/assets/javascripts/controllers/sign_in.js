TwoRooms.SignInController = Ember.Controller.extend({
	onSuccess: function(response) {
		localStorage['token'] = response.token;
		localStorage['name'] =response.name;
		localStorage['email'] = response.email;
		localStorage['user_id'] =response.user_id;

		if ( localStorage['afterAuth'] ) {
			this.transitionToRoute(localStorage['afterAuth']);
		}
		else {
			this.transitionToRoute('profile');			
		}
		localStorage.removeItem('afterAuth');

		TwoRooms.NotificationsManager.push("Logged in.", 'success');
	},
	onFail: function(response) {
		console.log(response.responseJSON.error);
		TwoRooms.NotificationsManager.push(response.responseJSON.error, 'danger');
		return false;
	},

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
			$.post("/users/sign_in.json", data).then(this.onSuccess.bind(this), this.onFail.bind(this));
		}
	}
});