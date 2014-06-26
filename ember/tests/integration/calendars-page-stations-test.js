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
    var button = find('button:contains("CCRC")').first();

    isOrange(button, '"CCRC" button should start out orange');

    click(button).then(function() {
      click('a:contains("Check in CCRC")').then(function() {
        isGreen(button, 'After checkin, button should turn green');
        hasText(button, "CCRC", 'After check-in, text should remain "CCRC"');
      });
    });

    click(button).then(function() {
      click('a:contains("Partial stipulation (CCRC)")').then(function() {
        isOrange(button, 'After partial stip, button should turn orange');
        hasText(button, "Triage", 'After checkin, text should change to "Triage"');
      });
    });

    click(button).then(function() {
      click('a:contains("Check in Triage")').then(function() {
        isGreen(button, 'After checkin, button should turn green');
        hasText(button, "Triage", 'After checkin, text should remain "Triage"');
      });
    });

    click(button).then(function() {
      click('a:contains("DCSS")').then(function() {
        isOrange(button, 'After dispatch, button should turn orange');
        hasText(button, "DCSS", 'After dispatch, text should change to "DCSS"');
      });
    });

    click(button).then(function() {
      click('a:contains("Check in DCSS")').then(function() {
        isGreen(button, 'After checkin, button should turn green');
        hasText(button, "DCSS", 'After checkin, text should remain "DCSS"');
      });
    });

  });
});


function isOrange(element, message) {
  equal(element.attr('class').match(/btn-warning/), "btn-warning", message);
}

function isGreen(element, message) {
  equal(element.attr('class').match(/btn-success/), "btn-success", message);
}

function hasText(element, text, message) {
  equal(element.text().trim(), text, message);
}
