import DS from 'ember-data';

export default DS.Model.extend({
  events              : DS.hasMany('event', {async: true}),
  caseNumber          : DS.attr('string'),
  checkedIn           : DS.attr('boolean'),
  currentStation      : DS.attr('string'),
  currentDelay        : DS.attr('string'),
  department          : DS.attr('string'),
  lastDisposition     : DS.attr('string'),
  petitioner          : DS.attr('string'),
  petitionerPresent   : DS.attr('boolean'),
  respondent          : DS.attr('string'),
  respondentPresent   : DS.attr('boolean')
});
