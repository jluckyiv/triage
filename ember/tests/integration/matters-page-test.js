import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Matters Page', {
  setup: function() {
    App = startApp();
    server = pretendCalendarServer();

  },
  teardown: function() {
    Ember.run(App, 'destroy');
    server.shutdown();
  }
});

test('Should navigate to the Matters page', function() {
  visit('/matters/20140623');
  andThen(function() {
    equal(find('.page-header:contains("Triage Matters")').length, 1, "Expect page to contain 'Triage Matters'");
    equal(find('.page-header:contains("All cases")').length, 1, "Expect page to contain 'All cases'");
    equal(find('.page-header:contains("June 23, 2014")').length, 1, "Expect page to contain 'June 23, 2014'");
  });
});

test('Should navigate to the date typed into the date form', function() {
  visit('/');
  fillIn('#date-input', '6/24/14');
  click('#date-submit');
  andThen(function() {
    equal(find('.page-header:contains("Triage Matters")').length, 1, "Expect page to contain 'Triage Matters'");
    equal(find('.page-header:contains("All cases")').length, 1, "Expect page to contain 'All cases'");
    equal(find('.page-header:contains("June 24, 2014")').length, 1, "Expect page to contain 'June 23, 2014'");
  });
});

