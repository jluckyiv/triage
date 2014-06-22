import Ember from 'ember';

var Router = Ember.Router.extend({
  location: TriageENV.locationType
});

Router.map(function() {
  this.route('about');
  this.resource('speakers', function() {
    this.route('show', {path: ':speaker_id'});
  });
  this.resource('calendars', {path: '/calendars/:date'});
});

export default Router;
