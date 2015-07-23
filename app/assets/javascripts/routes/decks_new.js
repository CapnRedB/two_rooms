// TwoRooms.DecksNewRoute = TwoRooms.AuthenticatedRoute.extend({
// 	actions: {
// 		save: function() {
// 			var model = this.get('controller').get('content');
// 			var self = this;
// 			model.save().then(function(){
// 				self.transitionTo('deck.index');
// 				TwoRooms.NotificationsManager.push("Deck successfully created", "success");
// 			}, function(response){
// 				var message = "Unable to create deck";
// 				console.log (response);
// 				if (response.name )
// 				{
// 					message = response.name;
// 				}
// 				TwoRooms.NotificationsManager.push(message, "danger");
// 			})
// 		},
// 		cancel: function(){
// 			this.transitionTo('decks.index');
// 		}
// 	}

// });