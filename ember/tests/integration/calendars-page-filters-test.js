import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Calendars Page Filters', {
  setup: function() {
    App = startApp();
    server = pretendCalendarServer();

  },
  teardown: function() {
    Ember.run(App, 'destroy');
    server.shutdown();
  }
});

test('Should filter by department', function() {
  visit('/calendars/20140623');
  andThen(function() {
    click('button.department-filter:contains("All")').then(function() {
      equal(find('button.department:contains("F201")').length, 1, "Filter for All should have one F201 case");
      equal(find('button.department:contains("F301")').length, 1, "Filter for All should have one F301 case");
      equal(find('button.department:contains("F401")').length, 1, "Filter for All should have one F401 case");
    });

    click('button.department-filter:contains("F201")').then(function() {
      equal(find('button.department:contains("F201")').length, 1, "Filter for F201 should have one F201 case");
      equal(find('button.department:contains("F301")').length, 0, "Filter for F201 should have no F301 case");
      equal(find('button.department:contains("F401")').length, 0, "Filter for F201 should have no F401 case");
    });

    click('button.department-filter:contains("F301")').then(function() {
      equal(find('button.department:contains("F201")').length, 0, "Should have no case from F201");
      equal(find('button.department:contains("F301")').length, 1, "Should have one case from F301");
      equal(find('button.department:contains("F401")').length, 0, "Should have no case from F401");
    });

    click('button.station-filter:contains("Self-help")').then(function() {
      equal(find('button.station:contains("Triage")').length, 0, "Should have no Triage case");
      equal(find('button.station:contains("CCRC")').length, 0, "Should have no CCRC case");
      equal(find('button.station:contains("DCSS")').length, 0, "Should have no DCSS case");
      equal(find('button.station:contains("Self-help")').length, 2, "Should have two Self-help cases");
    });

  });
});

