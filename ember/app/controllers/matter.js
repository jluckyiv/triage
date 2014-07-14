import Ember from 'ember';

export default Ember.ObjectController.extend({

  // needs: ['calendars'],
  needs: ['matters'],

  init: function() {
    this._super();
    this.syncPetitioner();
    this.syncRespondent();
    this.syncStation();
    this.syncCheckedIn();
    this.startPolling();
  },

  syncPetitioner: function() {
    this.set('petitionerAppeared', this.get('petitionerPresent'));
  }.observes('petitionerPresent'),

  syncRespondent: function() {
    this.set('respondentAppeared', this.get('respondentPresent'));
  }.observes('respondentPresent'),

  syncStation: function() {
    this.set('station', this.get('currentStation'));
  }.observes('currentStation'),

  syncCheckedIn: function() {
    this.set('isInStation', this.get('checkedIn'));
  }.observes('checkedIn'),

  isInTriage: function() {
    return this.get('station').indexOf('Triage') > -1;
  }.property(),

  startPolling: function() {
    return this.get('controllers.matters').set('pausedPollingAt', 0);
  },

  saveEvent: function(category, subject, action) {
    var matter = this.get('model');
    var hash = {
      matter: matter,
      category: category,
      subject: subject,
      action: action,
      unix_timestamp: new Date().getTime()
    };
    var event = this.store.createRecord('event', hash);
    this.startPolling();
    return event.save().then(function() {
      // Success callback
    }, function() {
      // Error callback
    });
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
    self.setProperties({'isInStation': false, 'station': 'Triage'});
    return self.saveDispoEvent(station, action).then(function() {
      return self.saveStationEvent('Triage', 'dispatch');
    });
  },

  actions: {
    checkin: function(station) {
      this.set('isInStation', true);
      return this.saveStationEvent(station, 'arrive');
    },

    dispatch: function(station) {
      this.setProperties({'isInStation': false, 'station': station});
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
      this.set('petitionerAppeared', true);
      return this.saveAppearanceEvent('petitioner', 'checkin');
    },
    respondentCheckin: function() {
      this.set('respondentAppeared', true);
      return this.saveAppearanceEvent('respondent', 'checkin');
    },
    petitionerCheckout: function() {
      this.set('petitionerAppeared', false);
      this.saveAppearanceEvent('petitioner', 'checkout');
    },
    respondentCheckout: function() {
      this.set('respondentAppeared', false);
      this.saveAppearanceEvent('respondent', 'checkout');
    },
    pausePolling: function() {
      this.get('controllers.matters').set('pausedPollingAt', new Date().getTime());
    }
  }
});

