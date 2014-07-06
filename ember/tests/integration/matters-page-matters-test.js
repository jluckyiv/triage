import startApp from 'triage/tests/helpers/start-app';
import pretendCalendarServer from 'triage/tests/helpers/pretend-calendar-server';

var App, server;

module('Integration - Matters Page Matters List', {
  setup: function() {
    App = startApp();
    server = pretendCalendarServer();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
    server.shutdown();
  }
});

test('Should list all matters', function() {
  visit('/matters/20140623');
  andThen(function() {
    equal(find('button.case-number').length, 4, "Expect 4 case numbers");
    equal(find('button.case-number:contains("RIK2100001")').length, 1, "Expect RIK2100001");
    equal(find('button.case-number:contains("RIK2100002")').length, 1, "Expect RIK2100002");
    equal(find('button.case-number:contains("RID2100003")').length, 1, "Expect RID2100003");
    equal(find('button.case-number:contains("RID2100006")').length, 1, "Expect RID2100006");
  });
});

test('Should omit matters not on calendar', function() {
  visit('/matters/20140623');
  andThen(function() {
    equal(find('button.case-number:contains("RID2100004")').length, 0, "Expect no RID2100004");
    equal(find('button.case-number:contains("RID2100005")').length, 0, "Expect no RID2100005");
  });
});

