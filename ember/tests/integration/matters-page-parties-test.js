import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Matters Page Parties Buttons', {
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
  visit('/matters/20140623');
  andThen(function() {
    isGreen(find('button:contains("KATHRYN HOLT")'), 'Expect KATHRYN HOLT button to be green');
    isGreen(find('button:contains("COURTNEY HOLLAND")'), 'Expect COURTNEY HOLLAND button to be green');
    isOrange(find('button:contains("PAM BLACK")'), 'Expect PAM BLACK button to be orange');
    isGreen(find('button:contains("HARVEY STEVENS")'), 'Expect HARVEY STEVENS button to be green');
    isOrange(find('button:contains("WENDELL PARKS")'), 'Expect WENDELL PARKS button to be orange');
    isOrange(find('button:contains("ANDREW FRANK")'), 'Expect ANDREW FRANK button to be orange');
    isOrange(find('button:contains("EDNA WADE")'), 'Expect EDNA WADE button to be orange');
    isOrange(find('button:contains("WAYNE ANDERSON")'), 'Expect WAYNE ANDERSON button to be orange');

    equal(find('button:contains("BRETT HOWELL")').length, 0, 'Expect no petitioner "BRETT HOWELL"');
    equal(find('button:contains("DUANE WOLFE")').length, 0, 'Expect no petitioner "DUANE WOLFE"');
    equal(find('button:contains("JOANNE PERKINS")').length, 0, 'Expect no respondent "JOANNE PERKINS"');
    equal(find('button:contains("MARIE HILL")').length, 0, 'Expect no respondent "MARIE HILL"');
  });
});

test('Should check in and check out parties', function() {
  visit('/matters/20140623');

  click('button:contains("HARVEY STEVENS")');
  click('a:contains("Check out HARVEY STEVENS")');
  andThen(function() {
    isOrange(find('button:contains("HARVEY STEVENS")'), 'HARVEY STEVENS button should turn orange');
  });

  click('button:contains("COURTNEY HOLLAND")');
  click('a:contains("Check out COURTNEY HOLLAND")');
  andThen(function() {
    isOrange(find('button:contains("COURTNEY HOLLAND")'), 'COURTNEY HOLLAND button should turn orange');
  });

  click('button:contains("WENDELL PARKS")');
  click('a:contains("Check in WENDELL PARKS")');
  andThen(function() {
    isGreen(find('button:contains("WENDELL PARKS")'), 'WENDELL PARKS button should turn green');
  });

  click('button:contains("PAM BLACK")');
  click('a:contains("Check in PAM BLACK")');
  andThen(function() {
    isGreen(find('button:contains("PAM BLACK")'), 'PAM BLACK button should turn green');
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
