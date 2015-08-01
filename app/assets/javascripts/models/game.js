// for more details see: http://emberjs.com/guides/models/defining-models/

TwoRooms.Game = DS.Model.extend({
  user_id: DS.attr('number'),
  deck: DS.belongsTo('deck'),
  game_type: DS.attr('string'),
  status: DS.attr('string'),
  outcome: DS.attr('string'),
  code: DS.attr('string'),

  players: DS.hasMany('game_player'),
  swaps: DS.hasMany('game_swap'),

  is_owned: function() {
  	return this.get('user_id') == localStorage['user_id'];
  }.property('user_id'),

});
