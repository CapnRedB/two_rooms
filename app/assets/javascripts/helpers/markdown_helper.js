Ember.Handlebars.registerBoundHelper('markdown', function(content) {
	return new Ember.Handlebars.SafeString(markdown.toHTML(content));
});