TwoRooms.Deck = DS.Model.extend({
  user_name: DS.attr('string'),
  user_id: DS.attr('number'),
  name: DS.attr('string'),
  description: DS.attr('string'),
  bury: DS.attr('boolean'),
  //warnings: DS.attr('string'),
  deck_cards: DS.hasMany('deck_cards', {async: true}),

  is_owned: function() {
  	return this.get('user_id') == localStorage['user_id'];
  }.property('user_id'),

  warnings: function() {
  	var warnings = [],
  		affiliations = ["required", "no_bury", "if_bury", "filler", "parity"];

  	deck_cards = this.get('deck_cards');
  	for (var i in affiliations)
  	{

  		var affiliation = affiliations[i];
  		var affiliation_cards = deck_cards.filterBy('affiliation', affiliation);

  		var red_count = affiliation_cards.filterBy('card.color', "Red").get('length'),
  			blue_count = affiliation_cards.filterBy('card.color', "Blue").get('length');

  		if ( red_count < blue_count )
  		{
			warnings.push("This deck has more " + affiliation + " blue cards than " + affiliation + " red cards. ");
  		}
  		else if ( red_count > blue_count )
  		{
  			warnings.push("This deck has more " + affiliation + " red cards than " + affiliation + " blue cards. ");
  		}
  	}
  	return warnings.join("");
  }.property('deck_cards.@each.affiliation','deck_cards.@each.card'),

  has_warnings: function() {
  	return this.get('warnings') != "";
  }.property('warnings'),

  player_count: function() {
  	var deck_cards = this.get('deck_cards');
  	var has_filler = false,
  		has_parity = false,
  		required_count = 0,
  		extendable = '',
  		parity = '';

  	if ( deck_cards )
  	{
	  	required_count = deck_cards.filterBy('affiliation', 'required').get('length');
	  	has_filler = ( deck_cards.filterBy('affiliation', 'filler').get('length') > 0 );
	  	has_parity = ( deck_cards.filterBy('affiliation', 'parity').get('length') > 0 );
  	}

  	if (has_filler)
  	{
  		extendable = "+";
  	}
  	if (! has_parity)
  	{
  		partiy = "(odd)";
  		if ( deck_cards.get('length') % 2 == 0)
  		{
  			parity = "(even)";
  		}
  	}

  	if ( this.get('bury') )
  	{
  		required_count--;
  	}

  	return required_count + extendable + " " + parity;
  }.property('deck_cards.@each.affiliation', 'bury'),

  title: function() {
    return this.get('name') + " by " + this.get('user_name');
  }.property('name', 'user_name'),

  card_summary: function() {
    
    var hash = {};  // [affiliation][title][colors]
    var lists = {}; // [affiliation][]
    
    var deck_cards = this.get('deck_cards');
    deck_cards.forEach(function(deck_card){
      var affiliation = deck_card.get('affiliation');
      var card = deck_card.get('card');
      var title = card.get('title').replace(/(Red|Blue) /, "");
      var color = card.get('color');
      if ( ! hash[affiliation] ) hash[affiliation] = {};
      if ( ! hash[affiliation][title] ) hash[affiliation][title] = {};

      hash[affiliation][title][color] = true; 
    });

    for ( var affiliation in hash )
    {
      if ( ! lists[affiliation] ) lists[affiliation] = [];
      for ( var title in hash[affiliation] )
      {
        if ( hash[affiliation][title]["Red"] && hash[affiliation][title]["Blue"] )
        {
          lists[affiliation].push("r/b " + title);
        }
        else
        {
          lists[affiliation].push(title);
        }
      }
    }
    summary = "";
    for ( var affiliation in lists )
    {
      if ( lists[affiliation].length )
      {
        summary += affiliation + ": ";
        last = lists[affiliation].pop();
        if ( lists[affiliation].length )
        {
          summary += lists[affiliation].join(", ") + " and ";
        }
        summary += last + ".<br />";
      }
    }
    return summary;
  }.property('deck_cards.@each.title'),


});