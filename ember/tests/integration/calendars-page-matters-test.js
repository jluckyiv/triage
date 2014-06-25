import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Calendars Page', {
  setup: function() {
    App = startApp();
    server = pretendCalendarServer();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
    server.shutdown();
  }
});

test('Should list all matters on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("RIK2100001")').length, 1);
    equal(find('button:contains("RIK2100002")').length, 1);
    equal(find('button:contains("RID2100003")').length, 1);
  });
});

test('Should omit matters not on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("RID2100004")').length, 0);
    equal(find('button:contains("RID2100005")').length, 0);
    equal(find('button:contains("RID2100006")').length, 0);
  });
});

