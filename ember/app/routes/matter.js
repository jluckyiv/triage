import Ember from 'ember';

export default Ember.Route.extend({

  activate: function(){
    this.onPoll();
  },

  deactivate: function(){
    Ember.run.cancel(this.get('timer'));
  },

  onPoll: function() {
    var self = this;
    this.set('timer', Ember.run.later(this, function() {
      console.log('this.refresh();');
      self.refresh();
      self.onPoll();
    }, 5000));
  }

});
