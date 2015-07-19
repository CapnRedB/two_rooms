TwoRooms.SignInController = Ember.Controller.extend({
	onSuccess: function(response) {
		localStorage['token'] = response.token;
		localStorage['name'] =response.name;
		localStorage['email'] = response.email;

		this.transitionToRoute('profile');
	},
	onFail: function(response) {
		console.error(response);
	},

	needs: ["application"],

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