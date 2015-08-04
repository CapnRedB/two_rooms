// for more details see: http://emberjs.com/guides/models/defining-models/

TwoRooms.GameLog = DS.Model.extend({
  gameId: DS.attr('number'),
  event: DS.attr('string'),
  command: DS.attr('string'),
  description: DS.attr('string')
});
