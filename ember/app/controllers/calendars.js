import Ember from 'ember';

export default Ember.ObjectController.extend({
  init: function() {
    if (window.test) { return; }
    this.set('pausedPollingAt', 0);
    this.tick();
  },

  tick: function() {
    var now = new Date();
    var self = this;

    self.setProperties({
      second        : now.getSeconds(),
      quarterMinute : Math.round(now.getSeconds() / 15),
      halfMinute    : Math.round(now.getSeconds() / 30),
      minute        : now.getMinutes(),
      hour          : now.getHours()
    });

    Ember.run.later(self, function(){
      self.tick();
    }, 1000);
  },

  pollModel: (function() {
    var started = this.get('pausedPollingAt');
    var now = new Date().getTime();
    if (now - started > 30000) {
      this.get('model').reload();
      this.set('pausedPollingAt', 0);
    }
  }).observes('quarterMinute')
});

