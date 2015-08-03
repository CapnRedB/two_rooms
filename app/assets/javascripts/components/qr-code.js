TwoRooms.QrCodeComponent = Ember.Component.extend({
	tagName: 'img',
	attributeBindings: ['src'],

	base: "http://api.qrserver.com/v1/create-qr-code/?size=275x275&data=",
	src: function() {
		return this.get('base') + content.replace(/#/, "%23");
	}
});
