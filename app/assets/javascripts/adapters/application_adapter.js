// Override the default adapter with the `DS.ActiveModelAdapter` which
// is built to work nicely with the ActiveModel::Serializers gem.
TwoRooms.ApplicationAdapter = DS.ActiveModelAdapter.extend({
	ajax: function(url, type, options) {
		options = options || {};
		options.headers = options.headers || {};
		options.headers['X-AUTHENTICATION-TOKEN'] = TwoRooms.Session.currentProp('token');
		return this._super(url, type, options);
	}

});
