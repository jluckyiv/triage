/* global require */

export default function pretendCalendarServer(attrs) {

  return {
    server: new Pretender(function() {

      this.get('/api/v1/calendars/:id', function(request) {

        var calendar, calendarMatters;

        calendar = this.calendars.find(function(calendar) {
          if (calendar.date === Date.parse(request.params.id).toString("yyyyMMdd")) {
            return calendar;
          }
        });

        calendarMatters = this.matters.filter(function(matter) {
          if (matter.calendar_id === calendar.id) {
            matter.events = this.events.filter(function(event) {
              if (event.matter_id === matter.id) {
                return event;
              }
            });
            return matter;
          }
        });

        return this.pretend200({calendar: calendar, matters: calendarMatters});
      });
    }),

    pretend200: function (data) {
      return [200, {"Content-Type": "application/json"}, JSON.stringify(data)];
    },

    calendars: [
      { id: 1, date: '20140623', matter_ids: [1,2,3] },
      { id: 2, date: '20140624', matter_ids: [4] },
      { id: 3, date: '20140630', matter_ids: [5,6] }
    ],

    matters: [
      { id: 1, calendar_id: 1, department: "F101", case_number: "RIK2100001", petitioner: "KATHRYN HOLT", petitioner_present: true, respondent: "HARVEY STEVENS", respondent_present: true, current_station: "CCRC", checked_in: true, event_ids: [1,2] },
      { id: 2, calendar_id: 1, department: "F102", case_number: "RIK2100002", petitioner: "COURTNEY HOLLAND", petitioner_present: true, respondent: "WENDELL PARKS", current_station: "Triage" },
      { id: 3, calendar_id: 1, department: "F103", case_number: "RID2100003", petitioner: "PAM BLACK", respondent: "ANDREW FRANK", current_station: "Triage" },
      { id: 4, calendar_id: 2, department: "F104", case_number: "RID2100004", petitioner: "BRETT HOWELL", respondent: "JOANNE PERKINS", current_station: "Triage" },
      { id: 5, calendar_id: 3, department: "F106", case_number: "RID2100005", petitioner: "DUANE WOLFE", respondent: "MARIE HILL", current_station: "Triage" },
      { id: 6, calendar_id: 3, department: "F106", case_number: "RID2100006", petitioner: "EDNA WADE", respondent: "WAYNE ANDERSON", current_station: "Triage" }
    ],

    events: [
      { id: 1, matter_id: 1, type: "checkin", subject: "Petitioner" },
      { id: 2, matter_id: 1, type: "checkin", subject: "Respondent" }
    ]
  };
}

