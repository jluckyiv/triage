import startApp from 'triage/tests/helpers/start-app';

var App;

module('Integration - Landing Page', {
  setup: function() {
    App = startApp();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
  }
});

test('Should welcome me to Triage', function() {
  visit('/').then(function() {
    equal(find('h2#title').text(), 'Welcome to Triage');
  });
});

test('Should link to the About page', function() {
  visit('/').then(function() {
    click("a:contains('About')").then(function() {
      equal(find('h2').text(), 'About');
    });
  });
});

test('Should link to the Speakers page', function() {
  visit('/').then(function() {
    click('a:contains("Speakers")').then(function() {
      equal(find('h3').text(), 'Speakers');
    });
  });
});

