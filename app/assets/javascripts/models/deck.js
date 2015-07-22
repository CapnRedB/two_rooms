TwoRooms.Deck = DS.Model.extend({
  user_name: DS.attr('string'),
  user_id: DS.attr('number'),
  name: DS.attr('string'),
  description: DS.attr('string'),
  bury: DS.attr('boolean'),
  deck_cards: DS.hasMany('deck_cards')
});