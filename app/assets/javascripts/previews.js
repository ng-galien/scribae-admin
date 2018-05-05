

$(document).ready(function() {
  Scribae.LOG_LEVEL = Scribae.LOG_DEBUG;
  Scribae.log(Scribae.LOG_INFO, "previews -> ready");

  Scribae.Terminal.triggers.preview.run = function() {
    Scribae.log(Scribae.LOG_TRACE, "preview run: ");
    $('#wait-container').addClass('hide');
    $('#iframe-container').removeClass('hide');   
  }
  Scribae.Terminal.triggers.preview.stop = function() {
    Scribae.log(Scribae.LOG_TRACE, "preview stop: ");   
    $('#wait-container').removeClass('hide');
    $('#iframe-container').addClass('hide');
  }
  Scribae.Terminal.triggers.preview.update = function(enlapsed) {
    Scribae.log(Scribae.LOG_TRACE, "preview update: "+ enlapsed);
    var iframe = document.getElementById('iframe-preview');
    iframe.src = iframe.src;
  }
  Scribae.Terminal.triggers.preview.error = function(error) {
    Scribae.log(Scribae.LOG_TRACE, "preview update: "+ error);
  }
  var silent = false;
  Scribae.Terminal.init(silent);

});