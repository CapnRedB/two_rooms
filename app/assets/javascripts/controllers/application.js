TwoRooms.ApplicationController = Ember.Controller.extend({
	session: null,
	signedIn: false,
	onProfile: function(){
		return this.currentPath == "profile.index";
	}.property("currentPath")
});