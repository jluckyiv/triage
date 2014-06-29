import Ember from 'ember';

export default Ember.Route.extend({

  model: function(params) {
    this.set('date', toUrlDate(params.date));
    return this.store.find('calendar', this.get('date'));
  },

});

function toUrlDate(dateText) {
  return Date.parse(dateText).toString("yyyyMMdd");
}
