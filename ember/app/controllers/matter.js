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
    this.set('petitionerHasAppeared', this.get('petitionerPresent'));
  }.observes('petitionerPresent'),

  syncRespondent: function() {
    this.set('respondentHasAppeared', this.get('respondentPresent'));
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

  needsInterpreter: function() {
    return this.get('interpreter').indexOf('English') === -1;
  }.property('interpreter'),

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

  petitionerAppeared: function() {
    this.set('petitionerHasAppeared', true);
    return this.saveAppearanceEvent('petitioner', 'checkin');
  },

  respondentAppeared: function() {
    this.set('respondentHasAppeared', true);
    return this.saveAppearanceEvent('respondent', 'checkin');
  },

  petitionerDisappeared: function() {
    this.set('petitionerHasAppeared', false);
    this.saveAppearanceEvent('petitioner', 'checkout');
  },

  respondentDisappeared: function() {
    this.set('respondentHasAppeared', false);
    this.saveAppearanceEvent('respondent', 'checkout');
  },

  actions: {
    undo: function() {
      var matter = this.get('model');
      this.store.find('event', {matter_id: matter.id}).then(function(events) {
        var lastTwo = events.slice(-2);
        var first = lastTwo.get('firstObject');
        var last = lastTwo.get('lastObject');
        last.destroyRecord();
        console.log('destroyed dispatch ' + last.get('id'));
        if(first.get('category').indexOf('disposition') > -1 ) {
          first.destroyRecord();
          console.log('destroyed disposition ' + first.get('id'));
        }
      });
    },

    checkin: function(station) {
      this.set('isInStation', true);
      return this.saveStationEvent(station, 'arrived');
    },

    checkinPetitioner: function(station) {
      console.log('checkinPetitioner ' + station);
      if (this.get('petitionerHasAppeared')) {
        this.respondentDisappeared();
      } else {
        this.petitionerAppeared();
        this.saveStationEvent(station, 'arrived');
      }
    },

    checkinRespondent: function(station) {
      console.log('checkinRespondent ' + station);
      if (this.get('respondentHasAppeared')) {
        this.petitionerDisappeared();
      } else {
        this.respondentAppeared();
      return this.saveStationEvent(station, 'arrived');
      }
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

    petitionerAppeared: function() {
      return this.petitionerAppeared();
    },
    respondentAppeared: function() {
      return this.respondentAppeared();
    },
    petitionerDisappeared: function() {
      return this.petitionerDisappeared();
    },
    respondentDisappeared: function() {
      return this.respondentDisappeared();
    },
    pausePolling: function() {
      this.get('controllers.matters').set('pausedPollingAt', new Date().getTime());
    }
  }
});

