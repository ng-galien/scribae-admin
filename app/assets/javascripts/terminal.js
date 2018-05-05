// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){  
  $('.tabs').tabs();
  Scribae.log(Scribae.LOG_DEBUG, 'terminal -> ready');
  var silent = false;
  Scribae.Terminal.init(silent);
});