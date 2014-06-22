import Ember from 'ember';

export default Ember.Route.extend({
  model: function(params) {
    var date = toUrlDate(params.date);
    return this.store.find('calendar', date);
  }
});

function toUrlDate(dateText) {
  return Date.parse(dateText).toString("yyyyMMdd");
}
