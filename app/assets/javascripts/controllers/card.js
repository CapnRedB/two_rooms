TwoRooms.CardController = Ember.Controller.extend({
	showDetail: false,
	detailLinkText: "More",

	actions: {
		toggleDetail: function(){
			var show = ! this.get('showDetail');
			if ( show ) {
				this.set('detailLinkText', "Less");
			} 
			else {
				this.set('detailLinkText', "More");
			}
			this.set('showDetail', show);
		}
	}
});