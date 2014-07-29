import Ember from 'ember';
import DateHelper from 'triage/helpers/date-helper';

export default Ember.ArrayController.extend({

  init: function() {
    this.setProperties({
      filterProperty: 'station',
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
    var hidden  = ['Hearing', 'Continue', 'Off calendar'];
    var content = this.get('content').sortBy('department', 'caseNumber');
    if (value !== "All") {
      // return content.filterBy(property, value);
      return content.filter(function(item /*, index, self*/ ) {
        // console.log('property = ' + property);
        // console.log('value = ' + value);
        // console.log('item.get(property) = ' + item.get(property));
        if (item.get(property).indexOf(value) > -1) { return true; }
      });
    } else {
      // return content;
      return content.filter(function(item /*, index, self*/ ) {
        // console.log('property = ' + property);
        // console.log('value = ' + value);
        // console.log('item.get(property) = ' + item.get(property));
        if (hidden.indexOf(item.get(property)) === -1) { return true; }
      });
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

