import DS from 'ember-data';

export default DS.Model.extend({
  events              : DS.hasMany('event', {async: true}),
  currentStation      : DS.attr('string'),
  checkedIn           : DS.attr('boolean'),
  department          : DS.attr('string'),
  petitioner          : DS.attr('string'),
  respondent          : DS.attr('string'),
  petitionerPresent   : DS.attr('boolean'),
  respondentPresent   : DS.attr('boolean')
});
