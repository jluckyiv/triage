case_one   = CaseNumber.create(court_code: "F", case_type: "RIK", case_number: "2100001")
case_two   = CaseNumber.create(court_code: "F", case_type: "RIK", case_number: "2100002")
case_three = CaseNumber.create(court_code: "F", case_type: "RID", case_number: "2100003")
case_four  = CaseNumber.create(court_code: "F", case_type: "RID", case_number: "2100004")
case_five  = CaseNumber.create(court_code: "F", case_type: "RID", case_number: "2100005")
case_six   = CaseNumber.create(court_code: "F", case_type: "RID", case_number: "2100006")

case_one.matters.create(  date: '20140623', department: "F201")
case_two.matters.create(  date: '20140623', department: "F301")
case_three.matters.create( date: '20140623', department: "F401")
case_four.matters.create(  date: '20140623', department: "F402")
case_five.matters.create( date: '20140624', department: "F402")
case_six.matters.create( date: '20140624', department: "F402")

# parties
