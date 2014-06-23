import DS from 'ember-data';

export default DS.Model.extend({
  code:    DS.attr('string'),
  type:    DS.attr('string'),
  number:  DS.attr('string'),
  matters: DS.hasMany('matter')
});

