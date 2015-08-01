// for more details see: http://emberjs.com/guides/models/defining-models/

TwoRooms.GamePlayer = DS.Model.extend({
  gameId: DS.attr('number'),
  userId: DS.attr('number'),
  cardId: DS.attr('number'),
  location: DS.attr('string'),
  leader: DS.attr('boolean'),
  votingForId: DS.attr('number')
});
