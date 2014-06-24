import DS from 'ember-data';

export default DS.Model.extend({
  matter:    DS.belongsTo('matter'),
  type:      DS.attr('string'),
  subject:   DS.attr('string')
});

