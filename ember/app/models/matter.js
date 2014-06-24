import DS from 'ember-data';

export default DS.Model.extend({
  calendar            : DS.belongsTo('calendar'),
  events              : DS.hasMany('event'),
  petitioner          : DS.attr('string'),
  petitionerPresent   : DS.attr('boolean'),
  respondentPresent   : DS.attr('boolean'),
  respondent          : DS.attr('string'),
  caseNumber          : DS.attr('string'),
  department          : DS.attr('string')
});
