// for more details see: http://emberjs.com/guides/models/defining-models/

TwoRooms.Game = DS.Model.extend({
  user_id: DS.attr('number'),
  deck: DS.belongsTo('deck', {async: true}),
  game_type: DS.attr('string'),
  status: DS.attr('string'),
  outcome: DS.attr('string'),
  code: DS.attr('string'),
  created_at: DS.attr('date'),

  players: DS.hasMany('game_player', {async: true}),
  swaps: DS.hasMany('game_swap'),


  is_owned: function() {
  	return this.get('user_id') == localStorage['user_id'];
  }.property('user_id'),

  join_link: function() {
    return window.location.origin + "/#/game/join/" + this.get('code');
  }.property('code'),

  join_qr: function() {
    var qr_base = "http://api.qrserver.com/v1/create-qr-code/?size=275x275&data=";
    return qr_base + this.get('join_link').replace(/#/, "%23");
  }.property('join_link'),

  actual_cards: function() {
    var count = this.get('players').get('length');
    var bury = this.get('deck').get('bury');
    if ( bury ) {
      count++;
    }
    var cards = [];
    var by_affiliation = {};
    this.get('deck').get('deck_cards').forEach(function(deck_card){
      var affiliation = deck_card.get('affiliation');
      var card = deck_card.get('card');

      if (! by_affiliation[affiliation] ) by_affiliation[affiliation] = [];
      by_affiliation[affiliation].push(card);
    });

    var required_affiliations = ["required", "no_bury"];
    if ( bury )
    {
      required_affiliations.push('if_bury');
    }
    required_affiliations.forEach(function(affiliation){
      if ( by_affiliation[affiliation] && by_affiliation[affiliation].length )
      {
        by_affiliation[affiliation].forEach(function(card){
          cards.push(card);
        });        
      }
    });

    if ( ( count % 2 == 1 ) && by_affiliation["parity"].length )
    {
      //var idx = Math.floor(Math.random() * by_affiliation["parity"].length);
      var card = by_affiliation["parity"].get('firstObject');
      cards.push(card);
    }

    while ( count > cards.length && by_affiliation["filler"].length )
    {
      by_affiliation["filler"].forEach(function(card){
        cards.push(card);
      });
    }

    return cards;
  }.property('players.length', 'deck.bury'),

  type_description: function(){
    if ( this.get("game_type") == "Basic" )
    {
      return "Basic Game (3 Rounds)";
    }
    
    if ( this.get("game_type") == "Advanced" )
    {
      return "Advanced Game (5 Rounds)";
    }
  }.property('game_type'),

  has_enough_players: function() {
    if ( this.get('deck') )
    {
      return this.get('players').get('length') >= this.get('deck').get('min_player_count')
    }
    return false;
  }.property('deck', 'players')
});






// players   burying   cards needed  players per team  add parity
// 6           6       3         no
// 7           7       3.          yes
// 8           8       4         no
// 9           9       4.          yes
// 10            10        5         no
// 6     true    7       3         yes
// 7     true    8       3.          no
// 8     true    9       4         yes
// 9     true    10        4.          no
// 10      true    11        5         yes
