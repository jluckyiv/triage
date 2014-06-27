triage
======
- Clone the repo (events branch)
- `cd` into the repo
- `cd` into the `ember` folder
- `npm install`
- `bower install`

### To start server using heroku backend
- `ember s --proxy http://dry-thicket-1258.herokuapp.com/`

### To see issue
- Open app in two browser instances
- In each instance, click on the buttons on the far right, creating inconsistent states
- Observe that even after reloading the model, the view states are inconsistent

### Relevant files
- `triage/ember/app/routes/calendar.js`
- `triage/ember/app/controllers/matter.js`
- `triage/ember/app/templates/-station.hbs`
