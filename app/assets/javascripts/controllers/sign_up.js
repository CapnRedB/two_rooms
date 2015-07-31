TwoRooms.SignUpController = Ember.Controller.extend({
	// needs: ["application"],

	name: "",
	email: "",
	password: "",

	actions: {
		create: function() {
			var data = {
				user: {
					name: this.get("name"),
					email: this.get("email"),
					password: this.get("password")
				}
			}
			var self = this;
			$.post("/users.json", data).then(function(response) {
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
				var message = "Sign Up Failed. ";
				if ( response.responseJSON.errors )
				{
					var errors = response.responseJSON.errors;
					message += "<ul>";
					for ( var i in errors )
					{
						var detail = errors[i][0];
						if ( detail )
						{
							message += "<li>" + i + " " + detail + ".</li>";
						}
						
					}
					message += "</ul>";
				}

				TwoRooms.NotificationsManager.push(message, "danger");
				return false;
			});
		}
	}
});


