import Ember from 'ember';

export default Ember.ObjectController.extend({
  dateString: function() {
    return formatDate(this.get('model.date'));
  }.property('date')
});

var formatDate = function(text) {
  return parseDate(text).toString("MMMM dd, yyyy");
};

var parseDate = function(text) {
  text = text.toString();
  return Date.parse(text);
};
