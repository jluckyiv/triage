import Ember from 'ember';

export default Ember.ObjectController.extend({

  actions: {
    petitionerCheckin: function() {
      this.set('petitionerPresent', true);
      var matter = this.get('model');
      var event = this.store.createRecord('event', {
        matter: matter,
        category: "appearance",
        subject: "petitioner",
        action: "checkin",
        timestamp: new Date().getTime()
      });
      event.save();
    },
    respondentCheckin: function() {
      this.set('respondentPresent', true);
      var matter = this.get('model');
      var event = this.store.createRecord('event', {
        matter: matter,
        category: "appearance",
        subject: "respondent",
        action: "checkin",
        timestamp: new Date().getTime()
      });
      event.save();
    },
    petitionerCheckout: function() {
      this.set('petitionerPresent', false);
      var matter = this.get('model');
      var event = this.store.createRecord('event', {
        matter: matter,
        category: "appearance",
        subject: "petitioner",
        action: "checkout",
        timestamp: new Date().getTime()
      });
      event.save();
    },
    respondentCheckout: function() {
      this.set('respondentPresent', false);
      var matter = this.get('model');
      var event = this.store.createRecord('event', {
        matter: matter,
        category: "appearance",
        subject: "respondent",
        action: "checkout",
        timestamp: new Date().getTime()
      });
      event.save();
    }
  }
});

