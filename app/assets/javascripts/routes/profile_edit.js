TwoRooms.ProfileEditRoute = TwoRooms.AuthenticatedRoute.extend({
	beforeModel: function() {
		this._super();
		if ( ! localStorage['name'] ) {
			TwoRooms.NotificationsManager.push("What is your name?", "warning");
		}
	},
	setupController: function(controller, model) {
		controller.set('name', localStorage['name']);
		controller.set('isNameBlank', localStorage['name'] == "")
	},
	actions: {
		save: function() {
			var self = this;

			var user_id = localStorage['user_id'];
			var name = this.controller.get('name');

			$.ajax("/users/" + user_id + ".json",{
					method: "PUT", 
					data: {user : { name: name} }
			}).then(function(){
				localStorage['name'] = name;
				self.controllerFor('profile').set('name', name);
				self.transitionTo('profile');
			});
		},
		cancel: function() {
			this.transitionTo('profile');
		}
	}
});