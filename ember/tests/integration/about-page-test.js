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

test('Should navigate to the About page', function() {
  visit('/about').then(function() {
    equal(find('h2').text(), 'About');
  });
});

test('Should link to the Home page', function() {
  visit('/about').then(function() {
    click('a:contains("Triage")').then(function() {
      notEqual(find('h2').text(), 'About');
    });
  });
});

