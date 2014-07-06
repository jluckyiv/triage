import Ember from 'ember';

export default Ember.Route.extend({

  model: function(params) {
    this.set('date', toUrlDate(params.date));
    return this.store.find('matter', {calendar: this.get('date')});
  },

  setupController: function (controller, model) {
    controller.set('model', model);
    controller.set('date', this.get('date'));
  },

  activate: function() {
    if (!window.test) {
      this.tick();
    }
  },

  untick: function() {
    if (this.get('timer')) {
      Ember.run.cancel(this.get('timer'));
    }
  },

  tick: function() {
    var now = new Date();
    var self = this;
    self.untick();
    self.setProperties({
      second        : now.getSeconds(),
      quarterMinute : Math.round(now.getSeconds() / 15),
      halfMinute    : Math.round(now.getSeconds() / 30),
      minute        : now.getMinutes(),
      hour          : now.getHours()
    });

    self.set('timer', Ember.run.later(self, function(){
      self.tick();
    }, 1000));
  },

  pollModel: (function() {
    var now     = new Date().getTime();
    var controller = this.controllerFor('matters');
    var started = controller.get('pausedPollingAt');

    if (now - started > 30000) {
      controller.set('pausedPollingAt', 0);
      return this.store.find('matter', {calendar: this.get('date')});
    }
  }).observes('quarterMinute'),

  deactivate: function() {
    this.untick();
  }
});

function toUrlDate(dateText) {
  return Date.parse(dateText).toString("yyyyMMdd");
}

