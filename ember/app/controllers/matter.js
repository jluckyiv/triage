import Ember from 'ember';

export default Ember.ObjectController.extend({

  hasReachedStation: function() {
    return this.get('checkedIn');
  }.property('currentStation', 'checkedIn'),

  showStations: function() {
    return this.get('model.currentStation') === 'Triage';
  }.property('currentStation', 'checkedIn'),

  saveEvent: function(category, subject, action) {
    var event = this.store.createRecord('event', {
      matter: this.get('model'),
      category: category,
      subject: subject,
      action: action,
      timestamp: new Date().getTime()
    });
    return event.save();
  },

  saveAppearanceEvent: function(subject, action) {
    return this.saveEvent("appearance", subject, action);
  },

  saveStationEvent: function(subject, action) {
    return this.saveEvent("station", subject, action);
  },

  saveDispoEvent: function(subject, action) {
    return this.saveEvent("disposition", subject, action);
  },

  sendToTriage: function(station, action) {
    var self = this;
    self.setProperties({'checkedIn': false, 'currentStation': 'Triage'});
    return self.saveDispoEvent(station, action).then(function() {
      return self.saveStationEvent('Triage', 'dispatch');
    });
  },

  actions: {
    checkin: function(station) {
      this.set('checkedIn', true);
      return this.saveStationEvent(station, 'arrive');
    },

    dispatch: function(station) {
      this.setProperties({'checkedIn': false, 'currentStation': station});
      return this.saveStationEvent(station, 'dispatch');
    },

    fullStip: function(station) {
      return this.sendToTriage(station, "fullstip");
    },
    partialStip: function(station) {
      return this.sendToTriage(station, "partialstip");
    },
    noStip: function(station) {
      return this.sendToTriage(station, "nostip");
    },

    petitionerCheckin: function() {
      this.set('petitionerPresent', true);
      return this.saveAppearanceEvent('petitioner', 'checkin');
    },
    respondentCheckin: function() {
      this.set('respondentPresent', true);
      return this.saveAppearanceEvent('respondent', 'checkin');
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

