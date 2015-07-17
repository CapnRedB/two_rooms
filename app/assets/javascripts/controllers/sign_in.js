TwoRooms.SignInController = Ember.Controller.extend({
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
			console.log(data);
			$.post("/users/sign_in.json", data).then(function(response){
				if ( response.token )
				{
					TwoRooms.Session.currentProp('token', response.token);
					TwoRooms.Session.currentProp('name', response.name);
					TwoRooms.Session.currentProp('email', response.email);
				}
			});
		}
	}
});