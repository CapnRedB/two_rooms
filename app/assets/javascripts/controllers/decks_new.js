TwoRooms.DecksNewController = Ember.ObjectController.extend({
	name: "",
	description: "",
	bury: false,

	actions: {
		create: function(){
			var deck = this.store.createRecord('deck', {
				name: this.get("name"),
				description: this.get("description"),
				bury: this.get("bury")
			});

			var self = this;
			deck.save().then(function(deck){
				TwoRooms.NotificationsManager.push("Created Deck " + self.get("name"));
				self.transitionToRoute('deck.index', deck);

			},function(response){				
				self.set("errors", message);
				var message = "Unable to create deck. ";
				console.log(response);
				if (response.errors )
				{
					for(var i in response.errors )
					{
						var detail = response.errors[i].detail;
						if ( detail )
						{
							message += detail + " ";
						}
					}
				}
				TwoRooms.NotificationsManager.push(message, "danger");

			});
		}
	}
});