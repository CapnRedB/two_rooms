TwoRooms.Deck = DS.Model.extend({
  user_name: DS.attr('string'),
  name: DS.attr('string'),
  description: DS.attr('string'),
  bury: DS.attr('boolean'),
});