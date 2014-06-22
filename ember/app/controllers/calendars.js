import Ember from 'ember';

export default Ember.ObjectController.extend({
  dateString: function() {
    return Date.parse(this.get('model.date').toString()).toString("MMMM dd, yyyy");
  }.property()
});
