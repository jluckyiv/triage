import DS from 'ember-data';

export default DS.Model.extend({
  calendar:   DS.belongsTo('calendar'),
  caseNumber: DS.attr('string'),
  department: DS.attr('string')
});
