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

test('Should list the correct parties on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("KATHRYN HOLT")').attr('class').match(/btn-success/), "btn-success", 'KATHRYN HOLT button should be green');
    equal(find('button:contains("COURTNEY HOLLAND")').attr('class').match(/btn-success/), "btn-success", 'COURTNEY HOLLAND button should be green');
    equal(find('button:contains("PAM BLACK")').attr('class').match(/btn-warning/), "btn-warning", 'PAM BLACK button should be orange');
    equal(find('button:contains("BRETT HOWELL")').length, 0, 'There should not be petitioner "BRETT HOWELL"');
    equal(find('button:contains("DUANE WOLFE")').length, 0, 'There should not be petitioner "DUANE WOLFE"');
    equal(find('button:contains("EDNA WADE")').length, 0, 'There should not be petitioner "EDNA WADE"');
    equal(find('button:contains("HARVEY STEVENS")').attr('class').match(/btn-success/), "btn-success", 'HARVEY STEVENS button should be green');
    equal(find('button:contains("WENDELL PARKS")').attr('class').match(/btn-warning/), "btn-warning", 'WENDELL PARKS button should be orange');
    equal(find('button:contains("ANDREW FRANK")').attr('class').match(/btn-warning/), "btn-warning", 'ANDREW FRANK button should be orange');
    equal(find('button:contains("JOANNE PERKINS")').length, 0, 'There should not be respondent "JOANNE PERKINS"');
    equal(find('button:contains("MARIE HILL")').length, 0, 'There should not be respondent "MARIE HILL"');
    equal(find('button:contains("WAYNE ANDERSON")').length, 0, 'There should not be respondent "WAYNE ANDERSON"');

  });
});

test('Should check in and check out parties', function() {
  visit('/calendars/20140623').then(function() {

    click('button:contains("HARVEY STEVENS")').then(function() {
      click('a:contains("Check out HARVEY STEVENS")').then(function() {
        equal(find('button:contains("HARVEY STEVENS")').attr('class').match(/btn-warning/), "btn-warning", 'HARVEY STEVENS button should turn orange');
      });
    });
    click('button:contains("COURTNEY HOLLAND")').then(function() {
      click('a:contains("Check out COURTNEY HOLLAND")').then(function() {
        equal(find('button:contains("COURTNEY HOLLAND")').attr('class').match(/btn-warning/), "btn-warning", 'COURTNEY HOLLAND button should turn orange');
      });
    });
    click('button:contains("WENDELL PARKS")').then(function() {
      click('a:contains("Check in WENDELL PARKS")').then(function() {
        equal(find('button:contains("WENDELL PARKS")').attr('class').match(/btn-success/), "btn-success", 'WENDELL PARKS button should turn green');
      });
    });
    click('button:contains("PAM BLACK")').then(function() {
      click('a:contains("Check in PAM BLACK")').then(function() {
        equal(find('button:contains("PAM BLACK")').attr('class').match(/btn-success/), "btn-success", 'PAM BLACK button should turn green');
      });
    });
  });
});

