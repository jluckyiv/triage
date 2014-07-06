import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Matters Page Departments List', {
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
  visit('/matters/20140623');
  andThen(function() {
    equal(find('button.department').length, 4, "Expect three cases");
    equal(find('button.department:contains("F201")').length, 2, "Expect one case from F201");
    equal(find('button.department:contains("F301")').length, 1, "Expect one case from F301");
    equal(find('button.department:contains("F401")').length, 1, "Expect one case from F401");
  });
});

test('Should list departments in numerical order', function() {
  visit('/matters/20140623');
  andThen(function() {
    equal(find('button.department').first().text(), "F201", "Expect first department listed to be F201");
    equal(find('button.department').last().text(), "F401", "Expect last department listed to be F401");
  });
});

