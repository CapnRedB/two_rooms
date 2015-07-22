
/** ----------------------------------------------
  START Notifications
  --------------------------------------------- */

/**
 * Notifications Manager of Notifications Widget
 * Object which manages incoming transactions and provides
 * access to App.Notification which can not be directly
 * accessed.
 *
 * @example
 *  App.NotificationsManager.push({type: 'error', msg: 'Unable to persist comment'});
 *  App.NotificationsManager.push({msg: 'Unable to persist comment'});
 *  App.NotificationsManager.push('Plain message');
 */
TwoRooms.NotificationsManager = Ember.Object.create({

	/**
	 * Array store for message objects
	 * type {Array}
	 */
	content: Ember.A(),

	push: function(message, type) {
		
		if ( ! message ) return;

		if ( ! type || ["success", "info", "warning", "danger"].indexOf(type) == -1 )
		{
			type = "warning";
		}

		this.get('content').pushObject({
			type: type,
			message: message
		});
	}

});


/**
 * A collection of Notification Items of Notification Widget
 * @requires App.NotificationsManager
 */
TwoRooms.NotificationsListComponent = Ember.Component.extend({

	classNames: ['Notifications'],

	tagName: 'section',

	content: TwoRooms.NotificationsManager.get('content')

});


/**
 * A Notification Item of Notification Widget
 * @requires App.NotificationsListComponent
 */
TwoRooms.NotificationsListItemComponent = Ember.Component.extend({

	classNames: ['Notifications__item', 'alert', 'alert-dismissible', 'affix-top'],

	classNameBindings: ['typeClass'],

	item: null,

	typeClass: function() {
		return 'alert-' + this.get('item.type');
	}.property('item.type'),

	// isSuccess: function() {
	// 	return this.get('item.type') === 'success';
	// }.property('item.type'),

	buttonIcon: function() {
		var icon = "fa-times";
		if (this.get('item.type') == 'success') {
			icon = "fa-check";
		}
		return icon;
	}.property('item.type'),

	duration: 6000,

	timer: null,

	showNotification: function(time) {
		var self = this;
		self.set('timer', window.setTimeout(function() {
			self.clearNotification();
			self.clearTimeout();
		}, time));
	},

	clearNotification: function() {
		this.$().fadeOut();
		TwoRooms.NotificationsManager.get('content').removeObject(this.get('content'));
	//	this.set('timer', null);
	},

	clearTimeout: function() {
		var self = this;
		if (this.get('timer') !== null) {
			window.clearTimeout(self.get('timer'));
			self.set('timer', null);
		}
	},

	didInsertElement: function() {
		// var self = this;
		this.showNotification(this.get('duration'));
	},

	actions: {
		clear: function() {
			this.clearNotification();
		}
	}

//	willDestroyElement: function() {
//	}

});

/** ----------------------------------------------
  END Notifications
  --------------------------------------------- */









// // TwoRooms.Notifications = Ember.Object.create({
// // 	content: Ember.A(),


// // 	// Usage TwoRooms.Notifications.push(message, type = 'warning');
// // 	push: function(message, type) {
		
// // 		if ( ! message ) return;

// // 		if ( ! type || ["success", "info", "warning", "danger"].indexOf(type) == -1 )
// // 		{
// // 			type = "warning";
// // 		}

// // 		this.get('content').pushObject({
// // 			type: type,
// // 			message: message
// // 		});
// // 	}
// // });

// TwoRooms.NotificationListComponent = Ember.Component.extend({
// 		classNames: ['Notifications'],

// 	tagName: 'section',

// 	content: TwoRooms.NotificationsManager.get('content')

// });

// TwoRooms.NotificationListItemComponent = Ember.Component.extend({
// 	item: null,

//  	classNames: ['Notifications__item', 'alert', 'alert-dismissible', 'ns-effect-scale'],

// 	//classNames: ['alert', 'alert-dismissable'],
// 	classNameBindings: ['alertType'],


// 	alertType: function() {
// 		return 'alert-' + this.get('item.type');
// 	}.property('item.type'),

// 	buttonIcon: function() {
// 		var icon = "fa-times";
// 		if (this.get('item.type') == 'success') {
// 			icon = "fa-check";
// 		}
// 		return icon;
// 	}.property('item.type'),

//     duration: 6000,

//     timer: null,

//     showNotification: function(time) {
//         var self = this;
//         self.set('timer', window.setTimeout(function() {
//             self.clearNotification();
//             self.clearTimeout();
//         }, time));
//     },

//     clearNotification: function() {
//         this.$().fadeOut();
//         App.NotificationsManager.get('content').removeObject(this.get('content'));
//         this.set('timer', null);
//     },

//     clearTimeout: function() {
//         var self = this;
//         if (self.get('timer') !== null) {
//             window.clearTimeout(self.get('timer'));
//             self.set('timer', null);
//         }
//     },

//     didInsertElement: function() {
//         var self = this;
//         this.showNotification(self.get('duration'));
//     },

// //     mouseEnter: function() {
// //         this.clearTimeout();
// //     },

// //     mouseLeave: function() {
// //         var halfSpeedTime = this.get('duration') / 2;
// //         this.showNotification(halfSpeedTime);
// //     },

// //     actions: {
// //         clear: function() {
// //             this.clearNotification();
// //         }
// //     }


// 	clearNotification: function() {
// 		this.$().fadeOut();
// 		TwoRooms.Notifications.get('content').removeObject(this.get('content'));
// 	},

// 	actions: {
// 		clear: function() {
// 			this.clearNotification();
// 		}

// 	}
// });