TwoRooms.LineFrameComponent = Ember.Component.extend({
	position: 'amid',
	color: 'grey',

	setPosition: function(pos) {
		if ( pos && ['above', 'amid', 'below'].indexOf(pos) != -1 ) {
			this.set('position', pos);
		}
	},
	setColor: function(col) {
		if ( col && ['grey', 'red', 'blue'].indexOf(col) != -1 ) {
			this.set('color', col);
		}
	},

	classNameBindings: ['position', 'color'],

	// _register: function() {
	// 	this.set('register-as', this);
	// }.on('init')

});
