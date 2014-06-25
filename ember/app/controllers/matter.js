import Ember from 'ember';

export default Ember.ObjectController.extend({

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

  actions: {
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

