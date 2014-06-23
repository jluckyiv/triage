import DS from 'ember-data';

export default DS.Model.extend({
  caseNumber: DS.attr('string'),
  calendar:   DS.belongsTo('calendar')
});
