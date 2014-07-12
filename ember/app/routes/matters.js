import Ember from 'ember';
import DateHelper from 'triage/helpers/date-helper';

var SECONDS = 1000;

export default Ember.Route.extend({

  model: function(params) {
    this.set('date', DateHelper.urlFormat(params.date));
    return this.findMatters();
  },

  findMatters: function() {
    return this.store.find('matter', {date: this.get('date'), now: new Date().getTime()});
  },

  activate: function() {
    if (!window.test) {
      this.tick();
    }
  },

  deactivate: function() {
    this.untick();
  },

  setupController: function (controller, model) {
    controller.set('model', model);
    controller.set('date', this.get('date'));
  },

  tick: function() {
    this.untick();

    var self = this;
    var now = new Date();
    self.setProperties({
      second        : now.getSeconds(),
      quarterMinute : Math.round(now.getSeconds() / 15),
      halfMinute    : Math.round(now.getSeconds() / 30),
      minute        : now.getMinutes(),
      hour          : now.getHours()
    });

    self.set('timer', Ember.run.later(self, function(){
      self.tick();
    }, 1 * SECONDS));
  },

  pollModel: (function() {
    var now        = new Date().getTime();
    var controller = this.controllerFor('matters');
    var started    = controller.get('pausedPollingAt');

    if (now - started > 30 * SECONDS) {
      controller.set('pausedPollingAt', 0);
      this.findMatters();
    }
  }).observes('quarterMinute'),

  untick: function() {
    if (this.get('timer')) {
      Ember.run.cancel(this.get('timer'));
    }
  },

});

