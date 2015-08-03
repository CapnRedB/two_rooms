// for more details see: http://emberjs.com/guides/models/defining-models/

TwoRooms.Game = DS.Model.extend({
  user_id: DS.attr('number'),
<<<<<<< HEAD
  deck: DS.belongsTo('deck'),
=======
  deck: DS.belongsTo('deck', {async: true}),
>>>>>>> feature-game-um
  game_type: DS.attr('string'),
  status: DS.attr('string'),
  outcome: DS.attr('string'),
  code: DS.attr('string'),

<<<<<<< HEAD
  players: DS.hasMany('game_player'),
=======
  players: DS.hasMany('game_player', {async: true}),
>>>>>>> feature-game-um
  swaps: DS.hasMany('game_swap'),

  is_owned: function() {
  	return this.get('user_id') == localStorage['user_id'];
  }.property('user_id'),

<<<<<<< HEAD
  join_link: function() {
    return window.location.origin + "/#/game/join/" + this.get('code');
  }.property('code'),

  join_qr: function() {
    var qr_base = "http://api.qrserver.com/v1/create-qr-code/?size=275x275&data=";
    return qr_base + this.get('join_link').replace(/#/, "%23");
  }.property('join_link'),


=======
>>>>>>> feature-game-um
});