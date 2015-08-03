// for more details see: http://emberjs.com/guides/models/defining-models/

TwoRooms.GameSwap = DS.Model.extend({
  gameId: DS.attr('number'),
  roundId: DS.attr('number'),
  sequence: DS.attr('number'),
  aToBId: DS.attr('number'),
  bToAId: DS.attr('number')
});
