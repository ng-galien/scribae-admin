//
var Scribae = Scribae || {};

Scribae.Terminal = Scribae.Terminal || {
  INFO: 0,
  ERROR: 10,
  CMD: 20,
  TRIGGER: 30,
  onMessage: function(data) {

  },
  triggers: {
    clear: function() {

    },
    preview: {
      status: function(status) {},
      run: function(status) {},
      stop: function(status) {},
      update: function(enlapsed) {},
      error: function(backtrace) {}
    },
    git: {
      commit: function() {}
    }
  },

  init: function(silent) {
    Scribae.log(Scribae.LOG_DEBUG, "Terminal::init => silent="+silent);
    Scribae.Channel.connected = function(channel, type, id) {
    };
    Scribae.Channel.disconnected = function(channel, type, id) {
    };
    Scribae.Channel.received = function(channel, type, id, data) {
      Scribae.Terminal.handleMessage(data, silent);
    };
    Scribae.Global.suscribe();
  },

  handleMessage: function(data, silent) {
    Scribae.log(Scribae.LOG_DEBUG, "Terminal::handleMessage => "+data.helper);
    if (data.helper < Scribae.Terminal.TRIGGER) {
      if (silent) {
        Scribae.log(Scribae.LOG_DEBUG, "Terminal::onMessage => "+data.message);
        Scribae.Terminal.onMessage(data);
      } else {
        Scribae.log(Scribae.LOG_DEBUG, "Terminal::addLog => "+data.message);
        Scribae.Terminal.addLog(data);

      }
    } 
    else {
      Scribae.log(Scribae.LOG_DEBUG, "Terminal::trigger => "+data.message);
      Scribae.Terminal.triggerSelect(data);
    }
  },

  addLog: function(log) {
    
    var type = log.loggable_type.toLowerCase();
    var target = $(`#${log.loggable_type}`);
    if (target.length) {
      var logNode = $('<div></div>');
      logNode.addClass('col s12 terminal-log terminal-' + log.info)
      info = I18n.t("terminal."+log.info);
      
      logNode.append($('<span></span>').addClass('terminal-head').html(info));
      logNode.append($('<span></span>').addClass('terminal-' + log.info).html(log.message));
      target.append(logNode);
      var height = target[0].scrollHeight;
      target.scrollTop(height);
    }
  },

  clearLogs: function(log) {
    var type = log.loggable_type.toLowerCase();
    var target = $(`#${log.loggable_type}`);
    target.html('');
  },


  triggerSelect: function(data) {
    var type = data.loggable_type.toLowerCase();
    switch(type) {
      case "preview":
        switch(data.info) {
          case I18n.t(type+".trigger.status"):
            switch(data.message) {
              case I18n.t("preview.trigger.value.run"):
                Scribae.Terminal.triggers.preview.run();
              break;
              case I18n.t("preview.trigger.value.stop"):
                Scribae.Terminal.triggers.preview.stop();
              break;
              default:
                Scribae.Terminal.triggers.preview.status(data.message); 
                break;
            }
          break;
          case I18n.t("preview.trigger.update"):
            Scribae.Terminal.triggers.preview.update(parseFloat(data.message));
          break;
          case I18n.t("preview.trigger.error"):
            Scribae.Terminal.triggers.preview.error(data.message);
          break;
          case I18n.t("preview.trigger.clear"):
            Scribae.Terminal.clearLogs(data);
          break;
        }
        break;
      case I18n.t("gitconfig"):
          
        break;
    }
  }

};