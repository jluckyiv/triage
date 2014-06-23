import startApp from 'triage/tests/helpers/start-app';

var App, server;

module('Integration - Calendars Page', {
  setup: function() {
    App = startApp();
    var calendars = pretendCalendars();
    var matters = pretendMatters();

    server = new Pretender(function() {

      this.get('/api/v1/calendars/:id', function(request) {

        var calendar = calendars.find(function(calendar) {
          if (calendar.date === Date.parse(request.params.id).toString("yyyyMMdd")) {
            return calendar;
          }
        });

        var calendarMatters = matters.filter(function(matter) {
          if (matter.calendar_id === calendar.id) {
            return matter;
          }
        });

        // return pretend200({calendar: calendar});
        return pretend200({calendar: calendar, matters: calendarMatters});
      });
    });

  },
  teardown: function() {
    Ember.run(App, 'destroy');
    server.shutdown();
  }
});

test('Should navigate to the Calendars page', function() {
  var text = "Triage calendar for June 23, 2014";
  visit('/calendars/20140623').then(function() {
    equal(find('#date').text(), text);
  });
});

test('Should navigate to the date in the form', function() {
  var text = "Triage calendar for June 24, 2014";
  visit('/').then(function() {
    fillIn('#date-input', '6/24/14');
    click('#date-submit').then(function() {
      equal(find('#date').text(), text);
    });
  });
});

test('Should list all matters for a calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("RID2100001")').length, 1);
    equal(find('button:contains("RID2100002")').length, 1);
  });
});

function pretend200(data) {
  return [200, {"Content-Type": "application/json"}, JSON.stringify(data)];
}

function pretendCalendars() {
  return [
    { id: 1, date: '20140623', matter_ids: [1,2] },
    { id: 2, date: '20140624', matter_ids: [3] },
    { id: 3, date: '20140630', matter_ids: [4,5,6] }
  ];
}

function pretendMatters() {
  return[
  { id: 1, case_number: "RID2100001", calendar_id: 1 },
  { id: 2, case_number: "RID2100002", calendar_id: 1 },
  { id: 3, case_number: "RID2100003", calendar_id: 2 },
  { id: 4, case_number: "RID2100004", calendar_id: 3 },
  { id: 5, case_number: "RID2100005", calendar_id: 3 },
  { id: 6, case_number: "RID2100006", calendar_id: 3 }
  ];
}
