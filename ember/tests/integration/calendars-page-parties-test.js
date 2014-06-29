import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Calendars Page Parties Buttons', {
  setup: function() {
    App = startApp();
    server = pretendCalendarServer();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
    server.shutdown();
  }
});

test('Should list the correct parties on calendar', function() {
  visit('/calendars/20140623').then(function() {
    isGreen(find('button:contains("KATHRYN HOLT")'), 'KATHRYN HOLT button should be green');
    isGreen(find('button:contains("COURTNEY HOLLAND")'), 'COURTNEY HOLLAND button should be green');
    isOrange(find('button:contains("PAM BLACK")'), 'PAM BLACK button should be orange');
    isGreen(find('button:contains("HARVEY STEVENS")'), 'HARVEY STEVENS button should be green');
    isOrange(find('button:contains("WENDELL PARKS")'), 'WENDELL PARKS button should be orange');
    isOrange(find('button:contains("ANDREW FRANK")'), 'ANDREW FRANK button should be orange');

    equal(find('button:contains("BRETT HOWELL")').length, 0, 'There should not be petitioner "BRETT HOWELL"');
    equal(find('button:contains("DUANE WOLFE")').length, 0, 'There should not be petitioner "DUANE WOLFE"');
    equal(find('button:contains("EDNA WADE")').length, 0, 'There should not be petitioner "EDNA WADE"');
    equal(find('button:contains("JOANNE PERKINS")').length, 0, 'There should not be respondent "JOANNE PERKINS"');
    equal(find('button:contains("MARIE HILL")').length, 0, 'There should not be respondent "MARIE HILL"');
    equal(find('button:contains("WAYNE ANDERSON")').length, 0, 'There should not be respondent "WAYNE ANDERSON"');

  });
});

test('Should check in and check out parties', function() {
  visit('/calendars/20140623').then(function() {

    click('button:contains("HARVEY STEVENS")').then(function() {
      click('a:contains("Check out HARVEY STEVENS")').then(function() {
        isOrange(find('button:contains("HARVEY STEVENS")'), 'HARVEY STEVENS button should turn orange');
      });
    });
    click('button:contains("COURTNEY HOLLAND")').then(function() {
      click('a:contains("Check out COURTNEY HOLLAND")').then(function() {
        isOrange(find('button:contains("COURTNEY HOLLAND")'), 'COURTNEY HOLLAND button should turn orange');
      });
    });
    click('button:contains("WENDELL PARKS")').then(function() {
      click('a:contains("Check in WENDELL PARKS")').then(function() {
        isGreen(find('button:contains("WENDELL PARKS")'), 'WENDELL PARKS button should turn green');
      });
    });
    click('button:contains("PAM BLACK")').then(function() {
      click('a:contains("Check in PAM BLACK")').then(function() {
        isGreen(find('button:contains("PAM BLACK")'), 'PAM BLACK button should turn green');
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
