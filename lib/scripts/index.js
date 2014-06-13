/**
  * Module dependencies.
  */
require('ember');

/**
  * Expose.
  */
module.exports = function(to) {
  var U = Em.Namespace.create({
    to: to
  });
  require('./upload')(U);
  require('./progress')(U);
  require('./drop')(U);
  return U;
};
