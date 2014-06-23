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

first.matters.create(department: "F101", case_number: "RID2100001")
first.matters.create(department: "F102", case_number: "RID2100002")
second.matters.create(department: "F103", case_number: "RID2100003")
third.matters.create(department: "F104", case_number: "RID2100004")
third.matters.create(department: "F104", case_number: "RID2100005")
third.matters.create(department: "F106", case_number: "RID2100006")

