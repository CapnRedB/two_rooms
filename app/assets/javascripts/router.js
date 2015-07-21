// For more information see: http://emberjs.com/guides/routing/

TwoRooms.Router.map(function() {
  // this.resource('posts');
  this.route('join');
  this.route('new_game');
  this.route('sign_up');
  this.route('sign_in');
  this.route('profile');

  // this.resource('decks');
  this.route('decks', function(){
    this.route('new');    
  });
  this.route('deck', {path: '/deck/:deck_id'}, function(){
    this.route('new');
    this.route('edit', {path: '/:deck_card_id'});
  });
  // this.route('add_deck_card', {path: '/add_deck_card/:deck_id'});
  // this.route('deck_card', {path: '/edit_deck_card/:deck_card_id'}, function(){
  //   this.route('cards');
  // });


  this.route('cards');
  this.route('card', {path: '/card/:card_id'});
});
