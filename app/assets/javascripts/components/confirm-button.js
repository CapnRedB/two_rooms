TwoRooms.ConfirmButtonComponent = Ember.Component.extend({
	isShowingConfirm: false,

	duration: 3000,
	timer: null,

	reset: function() {
		this.set('isShowingConfirm', false);
	},

	actions: {
		showConfirm: function() {
			this.set('isShowingConfirm', true);
			var self = this;
			this.set('timer', window.setTimeout(function() {
				self.reset();
				this.clearTimeout();
			},this.get('duration')));
		},
		confirm: function() {
			this.set('isShowingConfirm', true);
			this.sendAction('action', this.get('param'));
		}
	},

})