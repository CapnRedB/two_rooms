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
  		affiliations = ["required", "no_bury", "filler", "parity"];

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
  // def warnings
  //   warnings = []

  //   red_counts = {}
  //   blue_counts = {}

  //   ["required", "no_bury", "filter", "parity"].each do |affiliation|
  //     red_counts[affiliation] = deck_cards.select{|dc| dc.card.color == 'Red' and dc.affiliation == affiliation}.count
  //     blue_counts[affiliation] = deck_cards.select{|dc| dc.card.color == 'Blue' and dc.affiliation == affiliation}.count

  //     case red_counts[affiliation] <=> blue_counts[affiliation]
  //     when -1
  //       warnings << "This deck has more #{affiliation} blue cards than #{affiliation} red cards. "
  //     when 1
  //       warnings << "This deck has more #{affiliation} red cards than #{affiliation} blue cards. "
  //     end
  //   end

  //   if warnings.empty?
  //     null
  //   else
  //     #{}"<ul><li>" + warnings.join("</li><li>") + "</li></ul>"
  //     warnings.join()
  //   end
  // end

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
  }.property('deck_cards.@each.affiliation', 'bury')

});