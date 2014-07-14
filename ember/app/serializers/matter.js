import DS from 'ember-data';

export default DS.ActiveModelSerializer.extend({
  // typeForRoot: function(root) {
  //   if (root === 'matter' || root === 'matter') { root = 'case_number'; }
  //   return this._super(root);
  // },

  // keyForRelationship: function(key, kind) {
  //   if (key === 'case_number') { key = 'matter'; }
  //   return this._super(key, kind);
  // }
});
