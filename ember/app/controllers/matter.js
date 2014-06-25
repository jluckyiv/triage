import Ember from 'ember';

export default Ember.ObjectController.extend({

  inTriage: function() {
    return this.get('model.currentStation') === 'Triage';
  }.property('currentStation'),

  saveAppearanceEvent: function(subject, action) {
    var event = this.store.createRecord('event', {
      matter: this.get('model'),
      category: "appearance",
      subject: subject,
      action: action,
      timestamp: new Date().getTime()
    });
    event.save();
  },

  saveStationEvent: function(subject, action) {
    var event = this.store.createRecord('event', {
      matter: this.get('model'),
      category: "station",
      subject: subject,
      action: action,
      timestamp: new Date().getTime()
    });
    event.save();
  },

  saveDispoEvent: function(subject, action) {
    var event = this.store.createRecord('event', {
      matter: this.get('model'),
      category: "disposition",
      subject: subject,
      action: action,
      timestamp: new Date().getTime()
    });
    event.save();
  },

  actions: {
    checkin: function(currentStation) {
      this.set('checkedIn', true);
      this.saveStationEvent(currentStation, 'checkin');
    },

    fullStip: function(currentStation) {
      this.set('checkedIn', false);
      this.saveDispoEvent(currentStation, "fullstip");
      this.saveStationEvent('Triage', 'dispatch');
      this.set('currentStation', 'Triage');
    },
    partialStip: function(currentStation) {
      this.set('checkedIn', false);
      this.saveDispoEvent(currentStation, "partialstip");
      this.saveStationEvent('Triage', 'dispatch');
      this.set('currentStation', 'Triage');
    },
    noStip: function(currentStation) {
      this.set('checkedIn', false);
      this.saveDispoEvent(currentStation, "nostip");
      this.saveStationEvent('Triage', 'dispatch');
      this.set('currentStation', 'Triage');
    },

    petitionerCheckin: function() {
      this.set('petitionerPresent', true);
      this.saveAppearanceEvent('petitioner', 'checkin');
    },
    respondentCheckin: function() {
      this.set('respondentPresent', true);
      this.saveAppearanceEvent('respondent', 'checkin');
    },
    petitionerCheckout: function() {
      this.set('petitionerPresent', false);
      this.saveAppearanceEvent('petitioner', 'checkout');
    },
    respondentCheckout: function() {
      this.set('respondentPresent', false);
      this.saveAppearanceEvent('respondent', 'checkout');
    }
  }
});

