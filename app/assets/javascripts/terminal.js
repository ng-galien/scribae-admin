// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
var INFO = 0
var ERROR = 10
var CMD = 20
var TRIGGER = 30

function addlog(type, log) {
  
  console.log(log);
  var type = log.loggable_type.toLowerCase();
  var target = $(`#${log.loggable_type}`);
  var logNode = $('<div></div>');
  logNode.addClass('col s12 terminal-log terminal-' + log.info)
  info = I18n.t("terminal."+log.info);
  
  logNode.append($('<span></span>').addClass('terminal-head').html(info));
  logNode.append($('<span></span>').addClass('terminal-' + log.info).html(log.message));
  target.append(logNode);
  var height = target[0].scrollHeight;
  target.scrollTop(height);
  
}

function trigger(data) {

}

$(document).ready(function(){  
  $('.tabs').tabs();
  Scribae.log(Scribae.LOG_DEBUG, 'terminal -> ready');
  //Main
  Scribae.Channel.connected = function(channel, type, id) {

  };
  Scribae.Channel.disconnected = function(channel, type, id) {

  };
  Scribae.Channel.received = function(channel, type, id, data) {
    if (log.helper < TRIGGER) {
      addlog(type, data);
    } 
    else {
      trigger(data)
    }
  };
  Scribae.Global.suscribe();
  
});