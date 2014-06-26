import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Calendars Page Station Button', {
  setup: function() {
    App = startApp();
    server = pretendCalendarServer();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
    server.shutdown();
  }
});

test('Should allow changing stations', function() {
  visit('/calendars/20140623').then(function() {
    var thisButton = find('button:contains("CCRC")').first();

    equal(thisButton.attr('class').match(/btn-warning/), "btn-warning", '"CCRC" button should start out orange');

    click(thisButton).then(function() {
      click('a:contains("Check in CCRC")').then(function() {
        equal(thisButton.attr('class').match(/btn-success/), "btn-success", 'After check-in, button color should turn green');
        equal(thisButton.text().trim(), "CCRC", 'After check-in, text should remain "CCRC"');
      });
    });

    click(thisButton).then(function() {
      click('a:contains("Partial stipulation (CCRC)")').then(function() {
        equal(thisButton.attr('class').match(/btn-warning/), "btn-warning", 'After partial stip, button should turn orange');
        equal(thisButton.text().trim(), "Triage", 'After partial stip, text should change to "Triage"');
      });
    });

    click(thisButton).then(function() {
      click('a:contains("Check in Triage")').then(function() {
        equal(thisButton.attr('class').match(/btn-success/), "btn-success", 'After checkin, button should turn green');
        equal(thisButton.text().trim(), "Triage", 'After checkin, text should remain "Triage"');
      });
    });

    click(thisButton).then(function() {
      click('a:contains("DCSS")').then(function() {
        equal(thisButton.attr('class').match(/btn-warning/), "btn-warning", 'After dispatch, button should turn orange');
        equal(thisButton.text().trim(), "DCSS", 'After dispatch, text should change to "DCSS"');
      });
    });

    click(thisButton).then(function() {
      click('a:contains("Check in DCSS")').then(function() {
        equal(thisButton.attr('class').match(/btn-success/), "btn-success", 'After checkin, button should turn green');
        equal(thisButton.text().trim(), "DCSS", 'After checkin, text should remain "DCSS"');
      });
    });

  });
});

