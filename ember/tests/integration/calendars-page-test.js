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

test('Should navigate to the Calendars page', function() {
  var text = "Triage Calendar for June 23, 2014";
  visit('/calendars/20140623').then(function() {
    equal(find('#date').text().indexOf("Triage Calendar"), 0);
    equal(find('#date').text().indexOf("All cases") , 27);
    equal(find('#date').text().indexOf("June 23, 2014"), 47);
  });
});

test('Should navigate to the date typed into the date form', function() {
  var text = "Triage Calendar for June 24, 2014";
  visit('/').then(function() {
    fillIn('#date-input', '6/24/14');
    click('#date-submit').then(function() {
    equal(find('#date').text().indexOf("Triage Calendar"), 0);
    equal(find('#date').text().indexOf("All cases"), 27);
    equal(find('#date').text().indexOf("June 24, 2014"), 47);
    });
  });
});

