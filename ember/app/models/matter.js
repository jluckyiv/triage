import DS from 'ember-data';

export default DS.Model.extend({
  calendar            : DS.belongsTo('calendar'),
  events              : DS.hasMany('event', {async: true}),
  caseNumber          : DS.attr('string'),
  currentStation      : DS.attr('string'),
  checkedIn           : DS.attr('boolean'),
  lastStationedAt     : DS.attr('number'),
  department          : DS.attr('string'),
  petitioner          : DS.attr('string'),
  respondent          : DS.attr('string'),
  petitionerPresent   : DS.attr('boolean'),
  respondentPresent   : DS.attr('boolean')
});
