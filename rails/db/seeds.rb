# Courthouses
bly = Courthouse.create!(
  county: "Riverside",
  branch_name:    "Blythe Courthouse"
)

bly.build_address(
  street1: "265 N. Broadway",
  city:    "Blythe",
  state: "CA",
  zip:     "92225"
)

hmt = Courthouse.create!(
  county: "Riverside",
  branch_name:    "Hemet Courthouse"
)

hmt.build_address(
  street1: "880 N. State Street",
  city:    "Hemet",
  state: "CA",
  zip:     "92543"
)

ljc = Courthouse.create!(
  county: "Riverside",
  branch_name:    "Larson Justice Center"
)

ljc.build_address(
  street1: "46-200 Oasis Street",
  city:    "Indio",
  state: "CA",
  zip:     "92201"
)

riv = Courthouse.create!(
  county: "Riverside",
  branch_name:    "Riverside Family Law Courthouse"
)

riv.build_address(
  street1: "4175 Main Street",
  city:    "Riverside",
  state: "CA",
  zip:     "92501"
)

# Departments
f201 = riv.departments.create(
  name: "F201",
  judicial_officer: "H. Ronald Domnitz"
)
f301 = riv.departments.create(
  name: "F301",
  judicial_officer: "Gail A. O'Rane"
)
f401 = riv.departments.create(
  name: "F401",
  judicial_officer: "Kenneth J. Fernandez"
)
f402 = riv.departments.create(
  name: "F402",
  judicial_officer: "Steven G. Counelis"
)
f501 = riv.departments.create(
  name: "F501",
  judicial_officer: "Jackson Lucky"
)
f502 = riv.departments.create(
  name: "F502",
  judicial_officer: "Walter H. Kubelun"
)
d265 = bly.departments.create(
  name: "260",
  judicial_officer: "Sarah A. Christian"
)
d2e = ljc.departments.create(
  name: "2E",
  judicial_officer: "Gregory J. Olson"
)
d2j = ljc.departments.create(
  name: "2J",
  judicial_officer: "Otis Sterling III"
)
h2 = hmt.departments.create(
  name: "H2",
  judicial_officer: "James T. Warren"
)
h3 = hmt.departments.create(
  name: "H3",
  judicial_officer: "Kelly L. Hansen"
)
h4 = hmt.departments.create(
  name: "H4",
  judicial_officer: "Stephen J. Gallon"
)
h5 = hmt.departments.create(
  name: "H5",
  judicial_officer: "Bradley O. Snell"
)
