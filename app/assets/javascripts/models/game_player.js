// for more details see: http://emberjs.com/guides/models/defining-models/

TwoRooms.GamePlayer = DS.Model.extend({
  //game_id: DS.attr('number'),
  game: DS.belongsTo('game'),
  user_id: DS.attr('number'),
  //card_id: DS.attr('number'),
  card_id: DS.belongsTo('card'),
  location: DS.attr('string'),
  leader: DS.attr('boolean'),
  //voting_for: DS.attr('number'),
  voting_for: DS.belongsTo('game_player'),

  is_self: function() {
  	return this.get('user_id') == localStorage['user_id'];
  }.property('user_id'),

});
