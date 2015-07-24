// For more information see: http://emberjs.com/guides/routing/

TwoRooms.Router.map(function() {
  // this.resource('posts');
  this.route('join');
  this.route('sign_up');
  this.route('sign_in');
  this.route('oauth');
  this.route('profile', function(){
    this.route('edit');
  });


  this.route('games', function(){
    this.route('new');
  }); 
  this.route('game', {path: '/game/:game_id'});


  this.route('decks', function(){
    this.route('new');    
  });
  this.route('deck', {path: '/deck/:deck_id'}, function(){
    this.route('new');
    this.route('edit', {path: '/:deck_card_id'});
  });


  this.route('cards');
  this.route('card', {path: '/card/:card_id'});
});
