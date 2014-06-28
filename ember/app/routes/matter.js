import Ember from 'ember';

export default Ember.Route.extend({

  // activate: function(){
  //   this.onPoll();
  // },

  // deactivate: function(){
  //   Ember.run.cancel(this.get('timer'));
  // },

  // onPoll: function() {
  //   var self = this;
  //   this.set('timer', Ember.run.later(this, function() {
  //     console.log('this.refresh();');
  //     var id = this.get('content.id');
  //     var matter = self.store.find('matter', id);
  //     self.set('content', matter);
  //     // self.refresh();
  //     // self.reset();
  //     // self.get('content').reload();
  //     self.onPoll();
  //   }, 5000));
  // }

});
