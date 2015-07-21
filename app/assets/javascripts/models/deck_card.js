// for more details see: http://emberjs.com/guides/models/defining-models/

TwoRooms.DeckCard = DS.Model.extend({
	deck: DS.belongsTo('deck'),
	card: DS.belongsTo('card'),
	// title: DS.attr('string'),
	// color: DS.attr('string'),
	// faction: DS.attr('string'),
	// team: DS.attr('string'),
  	// deck_id: DS.attr('number', {async: true}),
 	// card_id: DS.attr('number'),
  	affiliation: DS.attr('string')
  	// all_cards: DS.hasMany('card')
});
