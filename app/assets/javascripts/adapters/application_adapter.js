// Override the default adapter with the `DS.ActiveModelAdapter` which
// is built to work nicely with the ActiveModel::Serializers gem.
TwoRooms.ApplicationAdapter = DS.ActiveModelAdapter.extend({
	shouldBackgroundReloadRecord: function(){return true;},
	isNewSerializerAPI: true,
	// shouldReloadAll: true,
	
	ajax: function(url, type, options) {
		var token = localStorage["token"];
		if ( token )
		{
			options = options || {};
			options.headers = options.headers || {};
			options.headers['X-AUTHENTICATION-TOKEN'] = token;
		}
		return this._super(url, type, options);
	},

	ajaxError: function(jqXHR) {
		var error = this._super(jqXHR);
		if (jqXHR && jqXHR.status === 422) {
			var jsonErrors = Ember.$.parseJSON(jqXHR.responseText)["errors"];
			return new DS.InvalidError(jsonErrors);
		}
		else {
			return error;
		}
	}


});
