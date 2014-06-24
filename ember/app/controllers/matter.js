import Ember from 'ember';

export default Ember.ObjectController.extend({

  actions: {
    petitionerCheckin: function() {
      this.set('petitionerPresent', true);
      var event = this.store.createRecord('event', {
        matterId: this.get('model.id'),
        type: "appearance",
        subject: "petitioner",
        action: "checkin",
        timestamp: new Date().getTime()
      });
      console.log('matter.id = ' + event.matterId);
      event.save();
    },
    respondentCheckin: function() {
      this.set('respondentPresent', true);
      var event = this.store.createRecord('event', {
        matterId: this.get('model.id'),
        type: "appearance",
        subject: "respondent",
        action: "checkin",
        timestamp: new Date().getTime()
      });
      console.log('matter.id = ' + event.matterId);
      event.save();
    },
    petitionerCheckout: function() {
      this.set('petitionerPresent', false);
      var event = this.store.createRecord('event', {
        matterId: this.get('model.id'),
        type: "appearance",
        subject: "petitioner",
        action: "checkout",
        timestamp: new Date().getTime()
      });
      console.log('matter.id = ' + event.matterId);
      event.save();
    },
    respondentCheckout: function() {
      this.set('respondentPresent', false);
      var event = this.store.createRecord('event', {
        matterId: this.get('model.id'),
        type: "appearance",
        subject: "respondent",
        action: "checkout",
        timestamp: new Date().getTime()
      });
      console.log('matter.id = ' + event.matterId);
      event.save();
    }
  }
});

