import Ember from 'ember';

export default Ember.ArrayController.extend({

  needs: ['calendars'],

  init: function() {
    this.setProperties({
      content: this.get('model'),
      itemController: ('matter'),
      sortAscending: true,
      sortProperties: ['department', 'caseNumber'],
      filterType: '',
      filterValue: ''
    });
  },

  dateString: function() {
    return formatDate(this.get('controllers.calendars.model.date'));
  }.property('controllers.calendars.model.date'),

  filtered: function() {
    var property = this.get('filterType');
    var value = this.get('filterValue');
    if (value) {
      return this.get('model').filterBy(property, value).sortBy('department', 'caseNumber');
    } else {
      return this.get('model').sortBy('department', 'caseNumber');
    }
  }.property('filterType', 'filterValue', '@each', '@each.station'),

  actions: {
    setStationFilter: function(station) {
      this.set('filterType', 'currentStation');
      this.set('filterValue', station);
    },
    setDepartmentFilter: function(department) {
      var value = department;
      this.set('filterType', 'department');
      this.set('filterValue', value);
    }
  }
});

var parseDate = function(text) {
  text = text.toString();
  return Date.parse(text);
};

var formatDate = function(text) {
  return parseDate(text).toString("MMMM dd, yyyy");
};

