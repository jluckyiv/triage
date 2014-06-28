import Ember from 'ember';

export default Ember.Route.extend({

  model: function(params) {
    this.set('date', toUrlDate(params.date));
    return this.store.find('calendar', this.get('date'));
  },

  afterModel: function() {
    console.log('model = ' + this.get('model'));
    this.tick();
  },

  tick: function() {
    var now = new Date();

    this.setProperties({
      second: now.getSeconds(),
      quarterMinute: Math.round(now.getSeconds() / 15),
      halfMinute: Math.round(now.getSeconds() / 30),
      minute: now.getMinutes(),
      hour:   now.getHours()
    });

    var self = this;
    setTimeout(function(){ self.tick(); }, 1000);
  },

  reload: (function() {
    console.log('reload();');
    this.modelFor(this.routeName).reload();
  }).observes('quarterMinute')

});

function toUrlDate(dateText) {
  return Date.parse(dateText).toString("yyyyMMdd");
}
