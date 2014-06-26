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
    var numberOfCCRCs = find('button:contains("CCRC")').length;
    var numberOfTriages = find('button:contains("Triage")').length;
    var thisButton = find('button:contains("CCRC")').first();

    equal(thisButton.attr('class').match(/btn-warning/), "btn-warning", 'CCRC button should be orange');

    click(thisButton).then(function() {
      click('a:contains("Check in CCRC")').then(function() {
        equal(thisButton.attr('class').match(/btn-success/), "btn-success", 'CCRC button should turn green');
      });
    });

    click(thisButton).then(function() {
      click('a:contains("Partial stipulation (CCRC)")').then(function() {
        equal(thisButton.text().trim(), "Triage", 'Button should now be labeled "Triage"');
        equal(thisButton.attr('class').match(/btn-warning/), "btn-warning", 'Button should be orange');
        equal(find('button:contains("CCRC")').length, numberOfCCRCs - 1, 'CCRC buttons should decrease by 1');
        equal(find('button:contains("Triage")').length, numberOfTriages + 1, 'Triage buttons should increase by 1');
      });
    });

    click(thisButton).then(function() {
      click('a:contains("Check in Triage")').then(function() {
        equal(thisButton.attr('class').match(/btn-success/), "btn-success", 'Triage button should turn green');
      });
    });

    click(thisButton).then(function() {
      click('a:contains("DCSS")').then(function() {
        equal(thisButton.text().trim(), "DCSS", 'Button should now be labeled "DCSS"');
      });
    });

  });
});

