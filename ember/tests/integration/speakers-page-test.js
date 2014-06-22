import startApp from 'triage/tests/helpers/start-app';

var App, server;

module('Integration - Speaker Page', {
  setup: function() {
    App = startApp();
    var speakers = pretendSpeakers();

    server = new Pretender(function() {
      this.get('/api/v1/speakers', function(request) {
        return pretend200({speakers: speakers});
      });

      this.get('/api/v1/speakers/:id', function(request) {
        var speaker = speakers.find(function(speaker) {
          if (speaker.id === parseInt(request.params.id, 10)) {
            return speaker;
          }
        });
        return pretend200({speaker: speaker});
      });
    });

  },
  teardown: function() {
    Ember.run(App, 'destroy');
    server.shutdown();
  }
});

test('Should allow navigation to the speakers page from the landing page', function() {
  visit('/').then(function() {
    click('a:contains("Speakers")').then(function() {
      equal(find('h3').text(), 'Speakers');
    });
  });
});

test('Should list all speakers and number of presentations', function() {
  visit('/speakers').then(function() {
    equal(find('a:contains("Bugs Bunny (2)")').length, 1);
    equal(find('a:contains("Wile E. Coyote (1)")').length, 1);
    equal(find('a:contains("Yosemite Sam (3)")').length, 1);
  });
});

test('Should be able to navigate to a speaker page', function() {
  visit('/speakers').then(function() {
    click('a:contains("Bugs Bunny")').then(function() {
      equal(find('h4').text(), 'Bugs Bunny');
    });
  });
});

test('Should be able visit a speaker page', function() {
  visit('/speakers/1').then(function() {
    equal(find('h4').text(), 'Bugs Bunny');
  });
});

function pretend200(data) {
  return [200, {"Content-Type": "application/json"}, JSON.stringify(data)];
}

function pretendSpeakers() {
  return [
    {
    id: 1,
    name: 'Bugs Bunny'
  },
  {
    id: 2,
    name: 'Wile E. Coyote'
  },
  {
    id: 3,
    name: 'Yosemite Sam'
  }
  ];
}