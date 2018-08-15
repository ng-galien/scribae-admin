

$(document).ready(function() {

  Scribae.LOG_LEVEL = Scribae.LOG_DEBUG;
  Scribae.log(Scribae.LOG_INFO, "previews -> ready");
  var iframe = document.getElementById('iframe-preview');
  var preloader = new Scribae.UI.Preloader('#preview-preloader');

  Scribae.Terminal.triggers.preview.start = function() {
    Scribae.log(Scribae.LOG_TRACE, "preview:start");
    preloader.show(I18n.t('preview.ui.starting'));
  }
  Scribae.Terminal.triggers.preview.run = function() {
    Scribae.log(Scribae.LOG_TRACE, "preview:run");
    preloader.hide(I18n.t('preview.ui.started'));
    $('#iframe-container').removeClass('hide');   
    iframe.src = "/scribae";
  }
  Scribae.Terminal.triggers.preview.stop = function() {
    Scribae.log(Scribae.LOG_TRACE, "preview stop: ");   
    preloader.hide(I18n.t('preview.ui.stopped'));
    $('#iframe-container').addClass('hide');
    iframe.src = "";
  }
  Scribae.Terminal.triggers.preview.update = function(enlapsed) {
    Scribae.log(Scribae.LOG_TRACE, "preview update: "+ enlapsed);
    iframe.src = iframe.src;
  }
  Scribae.Terminal.triggers.preview.error = function(error) {
    Scribae.log(Scribae.LOG_TRACE, "preview update: "+ error);
  }
  var silent = false;
  Scribae.Terminal.init(silent);
  var element = document.getElementById('toc-menu');
  if(element) {
    Scribae.Global.tocMenu = M.FloatingActionButton.init(element, {
      direction: 'left',
      hoverEnabled: false,
      toolbarEnabled: false
    });
  };

});