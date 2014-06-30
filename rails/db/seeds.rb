first  = Calendar.create(date: '20140623', department: "F201")
second = Calendar.create(date: '20140623', department: "F301")
third  = Calendar.create(date: '20140623', department: "F401")
fourth = Calendar.create(date: '20140623', department: "F402")
fifth = Calendar.create(date: '20140624', department: "F402")

case_one   = CaseNumber.create(court_code: "F", case_type: "RIK", case_number: "2100001")
case_two   = CaseNumber.create(court_code: "F", case_type: "RIK", case_number: "2100002")
case_three = CaseNumber.create(court_code: "F", case_type: "RID", case_number: "2100003")
case_four  = CaseNumber.create(court_code: "F", case_type: "RID", case_number: "2100004")
case_five  = CaseNumber.create(court_code: "F", case_type: "RID", case_number: "2100005")
case_six   = CaseNumber.create(court_code: "F", case_type: "RID", case_number: "2100006")

first.matters.create(  calendar_id: 1, case_number_id: 1  )
first.matters.create(  calendar_id: 1, case_number_id: 5  )
second.matters.create( calendar_id: 2, case_number_id: 2  )
third.matters.create(  calendar_id: 3, case_number_id: 3  )
fourth.matters.create( calendar_id: 4, case_number_id: 4  )
fifth.matters.create(  calendar_id: 5, case_number_id: 6  )

# parties
