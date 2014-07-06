import Ember from 'ember';

export default Ember.ObjectController.extend({
  content: {},
  actions: {
    chooseDate: function() {
      var text = this.get('newCalendarDate') || "today";
      var date = Date.parse(text);
      this.set('calendarDate', date.toString('yyyyMMdd'));
      this.set('newCalendarDate', "");
      this.transitionToRoute('matters', this.get('calendarDate'));
    }
  }
});
