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
      return self.saveStationEvent('Triage', 'dispatched');
    });
  },

  actions: {
    undo: function() {
      var matter = this.get('model');
      this.store.find('event', {matter_id: matter.id}).then(function(events) {
        var lastTwo = events.slice(-2);
        var first = lastTwo.get('firstObject');
        var last = lastTwo.get('lastObject');
        console.log('lastTwo = ' + lastTwo);
        console.log('first.id = ' + first.get('id'));
        console.log('last.id = ' + last.get('id'));
        if(last.get('subject').indexOf('Triage') > -1 && last.get('action').indexOf('dispatch') > -1) {
          first.destroyRecord();
        }
        last.destroyRecord();
      });
    },

    checkin: function(station) {
      this.set('isInStation', true);
      return this.saveStationEvent(station, 'arrived');
    },

    dispatch: function(station) {
      this.setProperties({'isInStation': false, 'station': station});
      return this.saveStationEvent(station, 'dispatched');
    },

    dispo: function(station) {
      var self = this;
      this.setProperties({'isInStation': false, 'station': station});
      return self.saveDispoEvent('Triage', station).then(function() {
        return self.saveStationEvent(station, 'dispatched');
      });
    },

    fullStip: function(station) {
      return this.sendToTriage(station, "full stipulation");
    },
    partialStip: function(station) {
      return this.sendToTriage(station, "partial stipulation");
    },
    noStip: function(station) {
      return this.sendToTriage(station, "no stipulation");
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

