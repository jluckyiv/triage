import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Matters Page Station Button', {
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
  visit('/matters/20140623').then(function() {
    var button = find('button.station:contains("Triage")').first();
    var sendToCount = find('li:contains("Send to")').length;
    equal(sendToCount, 1, "There should be one 'Send to' menu");

    isGreen(button, '"Triage" button should start out green');

    click(button).then(function() {
      click('a:contains("CCRC")').then(function() {
        isOrange(button, 'After dispatch, button should turn orange');
        hasText(button, "CCRC", 'After dispatch, text should change to "CCRC"');
      });
    });

    click(button).then(function() {
      click('a:contains("Check in CCRC")').then(function() {
        isGreen(button, 'After checkin, button should turn green');
        hasText(button, "CCRC", 'After check-in, text should remain "CCRC"');
      });
    });

    click(button).then(function() {
      // equal(sendToCount, 0, "There should be no 'Send to' menu");
      click('a:contains("Partial stipulation (CCRC)")').then(function() {
        isOrange(button, 'After partial stip, button should turn orange');
        hasText(button, "Triage", 'After partial stip, text should change to "Triage"');
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
        // equal(find('li:contains("Send to")').length, sendToCount, "Should have one fewer Send to header");
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
