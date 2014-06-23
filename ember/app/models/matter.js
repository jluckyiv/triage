import DS from 'ember-data';

export default DS.Model.extend({
  calendar:   DS.belongsTo('calendar'),
  petitioner: DS.attr('string'),
  respondent: DS.attr('string'),
  caseNumber: DS.attr('string'),
  department: DS.attr('string')
});
