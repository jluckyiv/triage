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

test('Should list departments for matters on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("F101")').length, 1);
    equal(find('button:contains("F102")').length, 1);
    equal(find('button:contains("F103")').length, 1);
  });
});

