/* global require */

export default function pretendCalendarServer(attrs) {
  var Server;
  var pretend200 = function (data) {
    return [200, {"Content-Type": "application/json"}, JSON.stringify(data)];
  };

  Server = new Pretender(function() {
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

  var calendars = [
    { id: 1, date: '20140623', matter_ids: [1,2,3] },
    { id: 2, date: '20140624', matter_ids: [4] },
    { id: 3, date: '20140630', matter_ids: [5,6] }
  ];

  var matters = [
    { id: 1, calendar_id: 1, department: "F201", case_number: "RIK2100001", petitioner: "KATHRYN HOLT", petitioner_present: true, respondent: "HARVEY STEVENS", respondent_present: true, current_station: "Triage", checked_in: true, event_ids: [1,2] },
    { id: 2, calendar_id: 1, department: "F301", case_number: "RIK2100002", petitioner: "COURTNEY HOLLAND", petitioner_present: true, respondent: "WENDELL PARKS", current_station: "Self-help" },
    { id: 3, calendar_id: 1, department: "F401", case_number: "RID2100003", petitioner: "PAM BLACK", respondent: "ANDREW FRANK", current_station: "Self-help" },
    { id: 4, calendar_id: 2, department: "F402", case_number: "RID2100004", petitioner: "BRETT HOWELL", respondent: "JOANNE PERKINS", current_station: "Self-help" },
    { id: 5, calendar_id: 3, department: "F402", case_number: "RID2100005", petitioner: "DUANE WOLFE", respondent: "MARIE HILL", current_station: "Self-help" },
    { id: 6, calendar_id: 3, department: "F201", case_number: "RID2100006", petitioner: "EDNA WADE", respondent: "WAYNE ANDERSON", current_station: "Self-help" }
  ];

  var events = [
    { id: 1, matter_id: 1, type: "checkin", subject: "Petitioner" },
    { id: 2, matter_id: 1, type: "checkin", subject: "Respondent" }
  ];

  return Server;
}

