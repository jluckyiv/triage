import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Calendars Page', {
  setup: function() {
    App = startApp();
    var calendars = pretendCalendars();
    var matters = pretendMatters();
    var events = pretendEvents();

    server = new Pretender(function() {

      this.get('/api/v1/calendars/:id', function(request) {

        var calendar, calendarMatters;

        calendar = calendars.find(function(calendar) {
          if (calendar.date === Date.parse(request.params.id).toString("yyyyMMdd")) {
            return calendar;
          }
        });

        calendarMatters = matters.filter(function(matter) {
          if (matter.calendar_id === calendar.id) {
            matter.events = events.filter(function(event) {
              if (event.matter_id === matter.id) {
                return event;
              }
            });
            return matter;
          }
        });

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

test('Should navigate to the date typed into the date form', function() {
  var text = "Triage calendar for June 24, 2014";
  visit('/').then(function() {
    fillIn('#date-input', '6/24/14');
    click('#date-submit').then(function() {
      equal(find('#date').text(), text);
    });
  });
});

function pretend200(data) {
  return [200, {"Content-Type": "application/json"}, JSON.stringify(data)];
}

function pretendCalendars() {
  return [
    { id: 1, date: '20140623', matter_ids: [1,2,3] },
    { id: 2, date: '20140624', matter_ids: [4] },
    { id: 3, date: '20140630', matter_ids: [5,6] }
  ];
}

function pretendMatters() {
  return [
    { id: 1, calendar_id: 1, department: "F101", case_number: "RIK2100001", petitioner: "KATHRYN HOLT", petitioner_present: true, respondent: "HARVEY STEVENS", respondent_present: true, current_station: "CCRC", checked_in: true, event_ids: [1,2] },
    { id: 2, calendar_id: 1, department: "F102", case_number: "RIK2100002", petitioner: "COURTNEY HOLLAND", petitioner_present: true, respondent: "WENDELL PARKS", current_station: "Triage" },
    { id: 3, calendar_id: 1, department: "F103", case_number: "RID2100003", petitioner: "PAM BLACK", respondent: "ANDREW FRANK", current_station: "Triage" },
    { id: 4, calendar_id: 2, department: "F104", case_number: "RID2100004", petitioner: "BRETT HOWELL", respondent: "JOANNE PERKINS", current_station: "Triage" },
    { id: 5, calendar_id: 3, department: "F106", case_number: "RID2100005", petitioner: "DUANE WOLFE", respondent: "MARIE HILL", current_station: "Triage" },
    { id: 6, calendar_id: 3, department: "F106", case_number: "RID2100006", petitioner: "EDNA WADE", respondent: "WAYNE ANDERSON", current_station: "Triage" }
  ];
}

function pretendEvents() {
  return [
    { id: 1, matter_id: 1, type: "checkin", subject: "Petitioner" },
    { id: 2, matter_id: 1, type: "checkin", subject: "Respondent" }
  ];
}
