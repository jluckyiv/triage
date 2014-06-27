import Ember from 'ember';
import DS from 'ember-data';

export default DS.Model.extend({
  didLoad: function() {
    this.poll();
  },
  poll: function() {
    var self = this;
    Ember.run.later(this, function() {
      console.log('reloading calendar');
      self.reload();
      self.poll();
    }, 15 * 1000); //every 15 seconds
  },
  date:    DS.attr('string'),
  matters: DS.hasMany('matter', {async: true})
});

