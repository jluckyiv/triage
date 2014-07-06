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
  visit('/');
  andThen(function() {
    equal(find('h2#title').text(), 'Welcome to Triage',
         "Expect index page to Welcome user");
  });
});

test('Should link to the About page', function() {
  visit('/');
  click("a:contains('About')");
  andThen(function() {
    equal(find('h2').text(), 'About', "Expect About page to have About header");
  });
});

