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
  visit('/calendars/20140623').then(function() {
    click('button.department-filter:contains("F201")').then(function() {
    equal(find('button.department:contains("F201")').length, 1, "Should have one case from F201");
    equal(find('button.department:contains("F301")').length, 0, "Should have no case from F301");
    equal(find('button.department:contains("F401")').length, 0, "Should have no case from F401");
    });

    click('button.department-filter:contains("F301")').then(function() {
    equal(find('button.department:contains("F201")').length, 0, "Should have no case from F201");
    equal(find('button.department:contains("F301")').length, 1, "Should have one case from F301");
    equal(find('button.department:contains("F401")').length, 0, "Should have no case from F401");
    });

  });
});

