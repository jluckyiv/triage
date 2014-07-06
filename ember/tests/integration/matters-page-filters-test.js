import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Matters Page Filters', {
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
  visit('/matters/20140623');
  click('button.department-filter:contains("All")');
  andThen(function() {
    equal(find('button.department:contains("F201")').length, 2, "Expect filter for All to have two F201 cases");
    equal(find('button.department:contains("F301")').length, 1, "Expect filter for All to have one F301 case");
    equal(find('button.department:contains("F401")').length, 1, "Expect filter for All to have one F401 case");
  });

  click('button.department-filter:contains("F201")');
  andThen(function() {
    equal(find('button.department:contains("F201")').length, 2, "Expect filter for F201 to have two F201 cases");
    equal(find('button.department:contains("F301")').length, 0, "Expect filter for F201 to have no F301 cases");
    equal(find('button.department:contains("F401")').length, 0, "Expect filter for F201 to have no F401 cases");
  });

  click('button.department-filter:contains("F301")');
  andThen(function() {
    equal(find('button.department:contains("F201")').length, 0, "Expect filter for F301 to have no F201 cases");
    equal(find('button.department:contains("F301")').length, 1, "Expect filter for F301 to have one F301 case");
    equal(find('button.department:contains("F401")').length, 0, "Expect filter for F301 to have no F401 cases");
  });

  click('button.station-filter:contains("Self-help")');
  andThen(function() {
    equal(find('button.station:contains("Triage")').length, 0, "Expect Self-help filter to have no Triage cases");
    equal(find('button.station:contains("CCRC")').length, 0, "Expect Self-help filter to have no CCRC cases");
    equal(find('button.station:contains("DCSS")').length, 0, "Expect Self-help filter to have no DCSS cases");
    equal(find('button.station:contains("Self-help")').length, 3, "Expect Self-help filter to have two Self-help cases");
  });
});

