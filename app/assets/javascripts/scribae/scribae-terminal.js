var Scribae = Scribae || {};

Scribae.Terminal = Scribae.Terminal || {
  
  triggers: {
    preview: {
      status: function(status) {},
      update: function(enlapsed) {},
      error: function(backtrace) {}
    },
    git: {
      commit: function() {}
    }
  },

  addLogToview: function(log) {
    
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
  triggerSelect: function(trigger) {
    var type = log.loggable_type.toLowerCase();
    switch(type) {
      case I18n.t("preview"):
        switch(data.info) {
          case I18n.t(type+".trigger.status"):
            Scribae.Terminal.triggers.preview.status(trigger.message);
          break;
          case I18n.t("preview.trigger.update"):
            Scribae.Terminal.triggers.preview.update(parseFloat(trigger.message));
          break;
          case I18n.t("preview.trigger.error"):
            Scribae.Terminal.triggers.preview.error(trigger.message);
          break;
        }
        break;
      case I18n.t("gitconfig"):
          
        break;
  
    }
  }

};