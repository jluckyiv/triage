import startApp from 'triage/tests/helpers/start-app';

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

test('Should list all matters on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("RIK2100001")').length, 1);
    equal(find('button:contains("RIK2100002")').length, 1);
    equal(find('button:contains("RID2100003")').length, 1);
  });
});

test('Should omit matters not on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("RID2100004")').length, 0);
    equal(find('button:contains("RID2100005")').length, 0);
    equal(find('button:contains("RID2100006")').length, 0);
  });
});

test('Should list departments for matters on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("F101")').length, 1);
    equal(find('button:contains("F102")').length, 1);
    equal(find('button:contains("F103")').length, 1);
  });
});

test('Should list petitioners on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("KATHRYN HOLT")').attr('class').match(/btn-success/), "btn-success", 'KATHRYN HOLT button should be green');
    equal(find('button:contains("COURTNEY HOLLAND")').attr('class').match(/btn-success/), "btn-success", 'COURTNEY HOLLAND button should be green');
    equal(find('button:contains("PAM BLACK")').attr('class').match(/btn-warning/), "btn-warning", 'PAM BLACK button should be orange');
  });
});

test('Should omit petitioners not on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("BRETT HOWELL")').length, 0, 'There should not be petitioner "BRETT HOWELL"');
    equal(find('button:contains("DUANE WOLFE")').length, 0, 'There should not be petitioner "DUANE WOLFE"');
    equal(find('button:contains("EDNA WADE")').length, 0, 'There should not be petitioner "EDNA WADE"');
  });
});

test('Should list respondents on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("HARVEY STEVENS")').attr('class').match(/btn-success/), "btn-success", 'HARVEY STEVENS button should be green');
    equal(find('button:contains("WENDELL PARKS")').attr('class').match(/btn-warning/), "btn-warning", 'WENDELL PARKS button should be orange');
    equal(find('button:contains("ANDREW FRANK")').attr('class').match(/btn-warning/), "btn-warning", 'ANDREW FRANK button should be orange');
  });
});

test('Should omit respondents not on calendar', function() {
  visit('/calendars/20140623').then(function() {
    equal(find('button:contains("JOANNE PERKINS")').length, 0, 'There should not be respondent "JOANNE PERKINS"');
    equal(find('button:contains("MARIE HILL")').length, 0, 'There should not be respondent "MARIE HILL"');
    equal(find('button:contains("WAYNE ANDERSON")').length, 0, 'There should not be respondent "WAYNE ANDERSON"');
  });
});

test('Should check in petitioner', function() {
  visit('/calendars/20141623').then(function() {
    click('button:contains("PAM BLACK")').then(function() {
      click('a:contains("Check in PAM BLACK")').then(function() {
        equal(find('button:contains("PAM BLACK")').attr('class').match(/btn-success/), "btn-success", 'PAM BLACK button should turn green');
      });
    });
  });
});

test('Should check in respondent', function() {
  visit('/calendars/20141623').then(function() {
    click('button:contains("WENDELL PARKS")').then(function() {
      click('a:contains("Check in WENDELL PARKS")').then(function() {
        equal(find('button:contains("WENDELL PARKS")').attr('class').match(/btn-success/), "btn-success", 'WENDELL PARKS button should turn green');
      });
    });
  });
});

test('Should check out petitioner', function() {
  visit('/calendars/20141623').then(function() {
    click('button:contains("COURTNEY HOLLAND")').then(function() {
      click('a:contains("Check out COURTNEY HOLLAND")').then(function() {
        equal(find('button:contains("COURTNEY HOLLAND")').attr('class').match(/btn-warning/), "btn-warning", 'COURTNEY HOLLAND button should turn orange');
      });
    });
  });
});

test('Should check out respondent', function() {
  visit('/calendars/20141623').then(function() {
    click('button:contains("HARVEY STEVENS")').then(function() {
      click('a:contains("Check out HARVEY STEVENS")').then(function() {
        equal(find('button:contains("HARVEY STEVENS")').attr('class').match(/btn-warning/), "btn-warning", 'HARVEY STEVENS button should turn orange');
      });
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
    { id: 1, calendar_id: 1, department: "F101", case_number: "RIK2100001", petitioner: "KATHRYN HOLT", petitioner_present: true, respondent: "HARVEY STEVENS", respondent_present: true, event_ids: [1,2] },
    { id: 2, calendar_id: 1, department: "F102", case_number: "RIK2100002", petitioner: "COURTNEY HOLLAND", petitioner_present: true, respondent: "WENDELL PARKS" },
    { id: 3, calendar_id: 1, department: "F103", case_number: "RID2100003", petitioner: "PAM BLACK", respondent: "ANDREW FRANK" },
    { id: 4, calendar_id: 2, department: "F104", case_number: "RID2100004", petitioner: "BRETT HOWELL", respondent: "JOANNE PERKINS" },
    { id: 5, calendar_id: 3, department: "F106", case_number: "RID2100005", petitioner: "DUANE WOLFE", respondent: "MARIE HILL" },
    { id: 6, calendar_id: 3, department: "F106", case_number: "RID2100006", petitioner: "EDNA WADE", respondent: "WAYNE ANDERSON" }
  ];
}

function pretendEvents() {
  return [
    { id: 1, matter_id: 1, type: "checkin", subject: "Petitioner" },
    { id: 2, matter_id: 1, type: "checkin", subject: "Respondent" }
  ];
}
