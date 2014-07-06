export default {

  parse: function(text) {
    return Date.parse(text.toString());
  },

  urlFormat: function(text) {
    return this.parse(text).toString("yyyyMMdd");
  },

  textFormat: function(text) {
    return this.parse(text).toString("MMMM dd, yyyy");
  }

};
