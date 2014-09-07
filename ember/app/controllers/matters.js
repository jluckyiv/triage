import Ember from 'ember';
import DateHelper from 'triage/helpers/date-helper';

export default Ember.ArrayController.extend({

  // TODO: Ineligible: 2rep/DV, Continue: NOPS, Off calendar: FTA, SH: foah:
  init: function() {
    this.setStationFilter('All');
    this.setProperties({
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
    switch (value) {
      case "All":
        return content;
      case "Pending":
        return content.filter(function(item /*, index, self*/ ) {
        var dispo = item.get('lastDisposition');
        if (!dispo || dispo.indexOf('Triage') !== 0) { return true; }
      });
      default:
        return content.filter(function(item /*, index, self*/ ) {
          if (item.get(property).indexOf(value) > -1) { return true; }
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

