Ember.Handlebars.registerBoundHelper('format-age', function(content){
	return moment(content).fromNow();
});
