import Ember from 'ember';
import DateHelper from 'triage/helpers/date-helper';

export default Ember.ArrayController.extend({

  init: function() {
    this.setProperties({
      filterProperty: 'department',
      filterValue: 'All',
      pausedPollingAt: 0
    });
  },

  dateString: function() {
    return DateHelper.textFormat(this.get('date'));
  }.property('date'),

  filtered: function() {
    var property = this.get('filterProperty');
    var value = this.get('filterValue');
    var content = this.get('content').sortBy('department', 'caseNumber');
    if (value !== "All") {
      return content.filterBy(property, value);
    } else {
      return content;
    }
  }.property('filterProperty', 'filterValue', '@each.currentStation'),

  setFilter: function(filterProperty, filterValue) {
    this.set('filterProperty', filterProperty);
    this.set('filterValue', filterValue);
  },
  setStationFilter: function(station) {
    this.setFilter('currentStation', station);
  },
  setDepartmentFilter: function(department) {
    this.setFilter('department', department);
  },

  actions: {
    setStationFilter: function(station) {
      this.setStationFilter(station);
    },
    setDepartmentFilter: function(department) {
      this.setDepartmentFilter(department);
    }
  }
});

