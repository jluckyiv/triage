bugs = Speaker.create(name: 'Bug Bunny')
wile = Speaker.create(name: 'Wile E. Coyote')
sam  = Speaker.create(name: 'Yosemite Sam')

bugs.presentations.create(title: "What's up with Docs?")
bugs.presentations.create(title: "Of course, you know, this means war.")

wile.presentations.create(title: "Getting the most from the Acme categlog.")

sam.presentations.create(title: "Shaaaad up!")
sam.presentations.create(title: "Ah hates rabbits.")
sam.presentations.create(title: "The Great horni-todes")

first =  Calendar.create(date: '20140623')
second = Calendar.create(date: '20140624')
third =  Calendar.create(date: '20140630')

first.matters.create( calendar_id: 1, department: "F101", case_number: "RIK2100001", petitioner: "KATHRYN HOLT", respondent: "HARVEY STEVENS", )
first.matters.create( calendar_id: 1, department: "F102", case_number: "RIK2100002", petitioner: "COURTNEY HOLLAND", respondent: "WENDELL PARKS" )
second.matters.create(calendar_id: 1, department: "F103", case_number: "RID2100003", petitioner: "PAM BLACK", respondent: "ANDREW FRANK" )
third.matters.create( calendar_id: 2, department: "F104", case_number: "RID2100004", petitioner: "BRETT HOWELL", respondent: "JOANNE PERKINS" )
third.matters.create( calendar_id: 3, department: "F106", case_number: "RID2100005", petitioner: "DUANE WOLFE", respondent: "MARIE HILL" )
third.matters.create( calendar_id: 3, department: "F106", case_number: "RID2100006", petitioner: "EDNA WADE", respondent: "WAYNE ANDERSON" )
