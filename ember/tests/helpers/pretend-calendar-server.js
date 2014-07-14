/* global require */

export default function pretendCalendarServer(attrs) {
  var Server, pretend200, mattersForDate, matters, events;
  Server = new Pretender(function() {

    this.get('/api/v1/cbm/triage/matters', function(request) {
      return (mattersForDate(request.queryParams.date));
    });

  });

  pretend200 = function (data) {
    return [200, {"Content-Type": "application/json"}, JSON.stringify(data)];
  };

   mattersForDate = function(date) {
    var calendarMatters;

    calendarMatters = matters.filter(function(matter) {
      if (matter.date === Date.parse(date).toString("yyyyMMdd")) {
        matter.events = events.filter(function(event) {
          if (event.matter_id === matter.id) {
            return event;
          }
        });
        return matter;
      }
    });

    return pretend200({matters: calendarMatters});
  };

   matters = [
    { date: '20140623', department: "F201", id: "RIK2100001", petitioner: "KATHRYN HOLT", petitioner_present: true, respondent: "HARVEY STEVENS", respondent_present: true, current_station: "Triage", checked_in: true, event_ids: [1,2] },
    { date: '20140623', department: "F301", id: "RIK2100002", petitioner: "COURTNEY HOLLAND", petitioner_present: true, respondent: "WENDELL PARKS", current_station: "Self-help" },
    { date: '20140623', department: "F401", id: "RID2100003", petitioner: "PAM BLACK", respondent: "ANDREW FRANK", current_station: "Self-help" },
    { date: '20140623', department: "F201", id: "RID2100006", petitioner: "EDNA WADE", respondent: "WAYNE ANDERSON", current_station: "Self-help" },
    { date: '20140624', department: "F402", id: "RID2100004", petitioner: "BRETT HOWELL", respondent: "JOANNE PERKINS", current_station: "Self-help" },
    { date: '20140630', department: "F402", id: "RID2100005", petitioner: "DUANE WOLFE", respondent: "MARIE HILL", current_station: "Self-help" },
  ];

   events = [
    { id: 1, matter_id: 1, type: "checkin", subject: "Petitioner" },
    { id: 2, matter_id: 1, type: "checkin", subject: "Respondent" }
  ];

  return Server;
}

