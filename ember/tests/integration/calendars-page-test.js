import startApp from 'triage/tests/helpers/start-app';

var App, server;

module('Integration - Calendars Page', {
  setup: function() {
    App = startApp();
    var calendars = pretendCalendars();
    var matters = pretendMatters();

    server = new Pretender(function() {

      this.get('/api/v1/calendars/:id', function(request) {

        var calendar, calendarMatters, matterParties;

        calendar = calendars.find(function(calendar) {
          if (calendar.date === Date.parse(request.params.id).toString("yyyyMMdd")) {
            return calendar;
          }
        });

        calendarMatters = matters.filter(function(matter) {
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
    equal(find('button:contains("RIK2100001")').length, 1);
    equal(find('button:contains("RIK2100002")').length, 1);
    equal(find('button:contains("RID2100003")').length, 1);
    equal(find('button:contains("RID2100004")').length, 0);
    equal(find('button:contains("RID2100005")').length, 0);
    equal(find('button:contains("RID2100006")').length, 0);
  });
});

test('Should list all departments for a calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("F101")').length, 1);
    equal(find('button:contains("F102")').length, 1);
    equal(find('button:contains("F103")').length, 1);
    equal(find('button:contains("F104")').length, 0);
    equal(find('button:contains("F105")').length, 0);
    equal(find('button:contains("F106")').length, 0);
  });
});

test('Should list all petitioners for a calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("KATHRYN HOLT")').length, 1, 'There should be petitioner "KATHRYN HOLT"');
    equal(find('button:contains("COURTNEY HOLLAND")').length, 1, 'There should be petitioner "COURTNEY HOLLAND"');
    equal(find('button:contains("PAM BLACK")').length, 1, 'There should be petitioner "PAM BLACK"');
    equal(find('button:contains("BRETT HOWELL")').length, 0, 'There should not be petitioner "BRETT HOWELL"');
    equal(find('button:contains("DUANE WOLFE")').length, 0, 'There should not be petitioner "DUANE WOLFE"');
    equal(find('button:contains("EDNA WADE")').length, 0, 'There should not be petitioner "EDNA WADE"');
  });
});

test('Should list all respondents for a calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("HARVEY STEVENS")').length, 1, 'There should be respondent "HARVEY STEVENS"');
    equal(find('button:contains("WENDELL PARKS")').length, 1, 'There should respondent "WENDELL PARKS"');
    equal(find('button:contains("ANDREW FRANK")').length, 1, 'There should not be respondent "ANDREW FRANK"');
    equal(find('button:contains("JOANNE PERKINS")').length, 0, 'There should not be respondent "JOANNE PERKINS"');
    equal(find('button:contains("MARIE HILL")').length, 0, 'There should not be respondent "MARIE HILL"');
    equal(find('button:contains("WAYNE ANDERSON")').length, 0, 'There should not be respondent "WAYNE ANDERSON"');
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
    { id: 1, department: "F101", case_number: "RIK2100001", calendar_id: 1, petitioner: "KATHRYN HOLT", respondent: "HARVEY STEVENS" },
    { id: 2, department: "F102", case_number: "RIK2100002", calendar_id: 1, petitioner: "COURTNEY HOLLAND", respondent: "WENDELL PARKS" },
    { id: 3, department: "F103", case_number: "RID2100003", calendar_id: 1, petitioner: "PAM BLACK", respondent: "ANDREW FRANK" },
    { id: 4, department: "F104", case_number: "RID2100004", calendar_id: 2, petitioner: "BRETT HOWELL", respondent: "JOANNE PERKINS" },
    { id: 5, department: "F106", case_number: "RID2100005", calendar_id: 3, petitioner: "DUANE WOLFE", respondent: "MARIE HILL" },
    { id: 6, department: "F106", case_number: "RID2100006", calendar_id: 3, petitioner: "EDNA WADE", respondent: "WAYNE ANDERSON" }
  ];
}

