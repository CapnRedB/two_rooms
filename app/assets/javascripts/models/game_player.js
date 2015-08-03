// for more details see: http://emberjs.com/guides/models/defining-models/

TwoRooms.GamePlayer = DS.Model.extend({
  game: DS.belongsTo('game'),
  user_id: DS.attr('number'),
  card: DS.belongsTo('card'),
  location: DS.attr('string'),
  leader: DS.attr('boolean'),
  voting_for: DS.belongsTo('game_player', {inverse: 'supporters'}),
  supporters: DS.hasMany('game_player', {inverse: 'voting_for'}),
  name: DS.attr('string'),

  is_self: function() {
  	return this.get('user_id') == localStorage['user_id'];
  }.property('user_id'),

});
