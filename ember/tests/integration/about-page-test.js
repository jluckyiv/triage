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
  visit('/about');
  andThen(function() {
    equal(find('h2').text(), 'About', "Expect About heading on About page");
  });
});

test('Should link to the Home page', function() {
  visit('/about');
  click('a:contains("Triage")');
  andThen(function() {
    notEqual(find('h2').text(), 'About', "Expect no About heading on Home page");
  });
});

