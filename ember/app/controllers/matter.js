import Ember from 'ember';

export default Ember.ObjectController.extend({

  actions: {
    petitionerCheckin: function() {
      this.set('petitionerPresent', true);
      console.log("Sending petitioner checkin event");
    },
    respondentCheckin: function() {
      this.set('respondentPresent', true);
      console.log("Sending respondent checkin event");
    },
    petitionerCheckout: function() {
      this.set('petitionerPresent', false);
      console.log("Sending petitioner checkout event");
    },
    respondentCheckout: function() {
      this.set('respondentPresent', false);
      console.log("Sending respondent checkout event");
    }
  }
});

