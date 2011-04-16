var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
};
define(['screen'], function(Screen) {
  var Main;
  return Main = (function() {
    __extends(Main, Screen);
    function Main() {
      Main.__super__.constructor.apply(this, arguments);
    }
    Main.prototype.update = function() {};
    Main.prototype.render = function() {};
    return Main;
  })();
});