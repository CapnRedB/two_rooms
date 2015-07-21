// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require ember
//= require ember-data
//= require ember-template-compiler
//= require active-model-adapter
//= require markdown
//= require_self
//= require ./two_rooms

// for more details see: http://emberjs.com/guides/application/
TwoRooms = Ember.Application.create({
	//  LOG_ACTIVE_GENERATION: true
	//rootElement: "#ember"
});


// $(document).ajaxSend(function(e, xhr, options) {
// 	if (options.data == null) {
// 		options.data = {};
// 	}
// 	options.data['authenticity_token'] = $('meta[name=csrf-token]').attr('content');
// });

//= require_tree .
