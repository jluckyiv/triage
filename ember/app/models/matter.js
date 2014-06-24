import DS from 'ember-data';

export default DS.Model.extend({
  calendar            : DS.belongsTo('calendar'),
  caseNumber          : DS.attr('string'),
  department          : DS.attr('string'),
  events              : DS.hasMany('event'),
  petitioner          : DS.attr('string'),
  respondent          : DS.attr('string'),
  petitionerPresent   : DS.attr('boolean'),
  respondentPresent   : DS.attr('boolean')
});
