TwoRooms.Deck = DS.Model.extend({
  user_name: DS.attr('string'),
  user_id: DS.attr('number'),
  name: DS.attr('string'),
  description: DS.attr('string'),
  bury: DS.attr('boolean'),
  deck_cards: DS.hasMany('deck_cards', {async: true}),

  is_owned: function() {
  	return this.get('user_id') == localStorage['user_id'];
  }.property('user_id'),

});