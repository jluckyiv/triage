import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Calendars Page Departments List', {
  setup: function() {
    App = startApp();
    server = pretendCalendarServer();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
    server.shutdown();
  }
});

test('Should list departments for matters on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button.department:contains("F201")').length, 1, "Should have one case from F201");
    equal(find('button.department:contains("F301")').length, 1, "Should have one case from F301");
    equal(find('button.department:contains("F401")').length, 1, "Should have one case from F401");
  });
});

