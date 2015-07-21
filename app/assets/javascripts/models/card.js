TwoRooms.Card = DS.Model.extend({
	title: DS.attr('string'),
	subtitle: DS.attr('string'),
	short_desc: DS.attr('string'),
	long_desc: DS.attr('string'),
	color: DS.attr('string'),
	faction: DS.attr('string'),
	team: DS.attr('string'),
	strategy: DS.attr('string'),
	required_text: DS.attr('string'),
	recommended_text: DS.attr('string'),
	large_icon: DS.attr('string'),
	text_id: DS.attr('string'),
});
