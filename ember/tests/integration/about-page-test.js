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

test('Should link to the About page from Landing page', function() {
  visit('/').then(function() {
    click("a:contains('About')").then(function() {
      equal(find('h2').text(), 'About');
    });
  });
});

test('Should navigate to the About page', function() {
  visit('/about').then(function() {
    equal(find('h2').text(), 'About');
  });
});

