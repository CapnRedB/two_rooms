// Override the default adapter with the `DS.ActiveModelAdapter` which
// is built to work nicely with the ActiveModel::Serializers gem.
TwoRooms.ApplicationAdapter = DS.ActiveModelAdapter.extend({
	isNewSerializerAPI: true,
	ajax: function(url, type, options) {
		var token = localStorage["token"];
		if ( token )
		{
			options = options || {};
			options.headers = options.headers || {};
			options.headers['X-AUTHENTICATION-TOKEN'] = token;
		}
		return this._super(url, type, options);
	}

});
