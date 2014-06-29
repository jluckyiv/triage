import Ember from 'ember';

export default Ember.ArrayController.extend({

  init: function() {
    this.setProperties({
      content: this.get('model'),
      itemController: ('matter'),
      sortAscending: true,
      sortProperties: ['department'],
      filterType: 'department',
      filterValue: 'All'
    });
  },

  filtered: function() {
    var property = this.get('filterType');
    var value = this.get('filterValue');
    if (value === 'All') { return this.get('content'); }
    console.log('filterBy(' + property + ', ' + value + ');');
    return this.get('content').filterBy(property, value).sortBy('department');
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

