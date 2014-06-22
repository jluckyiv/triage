import startApp from 'triage/tests/helpers/start-app';

var App, server;

module('Integration - Calendars Page', {
  setup: function() {
    App = startApp();
    var calendars = pretendCalendars();
    // var matters = pretendMatters();

    server = new Pretender(function() {
      // this.get('/api/v1/calendars', function(request) {
      //   return pretend200({calendars: calendars, matters: matters});
      // });

      this.get('/api/v1/calendars/:id', function(request) {

        var calendar = calendars.find(function(calendar) {
          if (calendar.id === parseInt(request.params.id, 10)) {
            return calendar;
          }
        });

        // var calendarMatters = matters.filter(function(matter) {
        //   if (matter.calendar_id === calendar.id) {
        //     return matter;
        //   }
        // });

        return pretend200({calendar: calendar});
        // return pretend200({calendar: calendar, matter: calendarMatters});
      });
    });

  },
  teardown: function() {
    Ember.run(App, 'destroy');
    server.shutdown();
  }
});

test('Should navigate to the Calendars page', function() {
  visit('/calendars/20140623').then(function() {
    var text = "Calendar for June 23, 2014";
    equal(find('#date').text(), text);
  });
});

// test('Should list all calendars and number of matters', function() {
//   visit('/calendars').then(function() {
//     equal(find('a:contains("Bugs Bunny (2)")').length, 1);
//     equal(find('a:contains("Wile E. Coyote (1)")').length, 1);
//     equal(find('a:contains("Yosemite Sam (3)")').length, 1);
//   });
// });

// test('Should be able visit a calendar page', function() {
//   visit('/calendars/1').then(function() {
//     equal(find('h4').text(), 'Bugs Bunny');
//   });
// });

// test('Should list all matters for a calendar', function() {
//   visit('/calendars/1').then(function() {
//     equal(find('li:contains("What\'s up with Docs?")').length, 1);
//     equal(find('li:contains("Of course, you know, this means war.")').length, 1);
//   });
// });

function pretend200(data) {
  return [200, {"Content-Type": "application/json"}, JSON.stringify(data)];
}

function pretendCalendars() {
  return [
    { id: 20140623, matter_ids: [1,2] },
    { id: 20140624, matter_ids: [3] },
    { id: 20140630, matter_ids: [4,5,6] }
  ];
}

// function pretendMatters() {
//   return[
//   { id: 1, caseNumber: "RID2100001", calendar_id: 1 },
//   { id: 2, caseNumber: "RID2100002", calendar_id: 1 },
//   { id: 3, caseNumber: "RID2100003", calendar_id: 2 },
//   { id: 4, caseNumber: "RID2100004", calendar_id: 3 },
//   { id: 5, caseNumber: "RID2100005", calendar_id: 3 },
//   { id: 6, caseNumber: "RID2100006", calendar_id: 3 }
//   ];
// }
