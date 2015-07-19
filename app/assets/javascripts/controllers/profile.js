TwoRooms.ProfileController = Ember.Controller.extend({
	actions: {
		sign_out: function() {
			//clear session storage
			//redirect to rails sign out
			localStorage.clear();
			$.ajax("/users/sign_out", { method: "DELETE" });
			this.transitionToRoute("/");
		}
	}
})