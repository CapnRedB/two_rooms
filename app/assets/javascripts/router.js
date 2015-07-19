// For more information see: http://emberjs.com/guides/routing/

TwoRooms.Router.map(function() {
  // this.resource('posts');
  this.route('join');
  this.route('new_game');
  this.route('sign_up');
  this.route('sign_in');
  this.route('profile');

  // this.resource('decks');
  this.route('decks');
  this.route('new_deck');
  this.route('edit_deck', {path: '/edit_deck/:deck_id'});
});
