TwoRooms.NewDeckController = Ember.ObjectController.extend({
	name: "",
	description: "",
	bury: false,

	actions: {
		submit: function(){
			var deck = this.store.createRecord('deck', {
				name: this.get("name"),
				description: this.get("description"),
				bury: this.get("bury")
			});

			var self = this;
			deck.save().then(function(deck){
				self.transitionToRoute('edit_deck', deck);
			},function(deck){
				console.log("failed to save");
				console.log(deck);
			});
		}
	}
});