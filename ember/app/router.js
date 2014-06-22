import Ember from 'ember';

var Router = Ember.Router.extend({
  location: TriageENV.locationType
});

Router.map(function() {
  this.route('about');
  this.resource('speakers');
});

export default Router;
