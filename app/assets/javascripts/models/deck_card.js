// for more details see: http://emberjs.com/guides/models/defining-models/

TwoRooms.DeckCard = DS.Model.extend({
	deck: DS.belongsTo('deck'),
	card: DS.belongsTo('card'),
  	affiliation: DS.attr('string')
});
