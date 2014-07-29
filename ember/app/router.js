import Ember from 'ember';

var Router = Ember.Router.extend({
  location: TriageENV.locationType
});

Router.map(function() {
  this.route('about');
  this.resource('calendars', {path: '/calendars/:date'});
  this.resource('matters', {path: '/matters/:date'});
});

export default Router;
