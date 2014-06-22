import Ember from 'ember';

export default Ember.ObjectController.extend({
  dateString: function() {
    return Date.parse(this.get('model.id')).toString("MMMM dd, yyyy");
  }.property('id')
});
