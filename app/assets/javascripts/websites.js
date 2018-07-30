/*Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/

//Modals

var gitModal;
var gitPreloader;
var settingsModal;
var styleModal;

var updateStatus = false;
var FAB;
var serverRunning = false

function showTerminal(id) {
  window.open(`/websites/$(id)/terminal`, 'Terminal', 
  directories=0,titlebar=0,toolbar=0,location=0,status=0,     
    menubar=0,scrollbars=no,resizable=no,
      width=400,height=350);
}

function updateMenu() {
  //serverRunning = $("#menu-container").find('[data-status]').attr('data-status');
  //console.log('preview running '+serverRunning);
  var elem = document.querySelector('#menu-container .fixed-action-btn');
  FAB = M.FloatingActionButton.init(elem, {
    direction: 'bottom',
    hoverEnabled: false,
    toolbarEnabled: false
  });
}

function checkStatus(data) {
  //console.log(data);
  eval(data);
  var new_status = $("#menu-temp").find('[data-status]').attr('data-status');
  console.log('preview temp running '+new_status);
  if(serverRunning !== new_status) {
    console.log("server status changed")
    var open = FAB.isOpen;
    $("#menu-container").html( $("#menu-temp").html());
    updateMenu();
    if (open) {
      FAB.open();
    }
  }
}

$(document).ready(function() {
  Scribae.LOG_LEVEL = Scribae.LOG_DEBUG;
  Scribae.log(Scribae.LOG_INFO, "websites -> ready");

  //=========================================================
  //MATERIALIZE INIT
  //Menu
  updateMenu();
  var element = undefined;
  
  //Parallax
  $('.parallax').parallax();

  //Setting modal
  element = document.getElementById('website-settings');
  if(element) {
    settingsModal = M.Modal.init(element, {});
  }

  element = document.getElementById('git-settings');
  if(element) {
    gitModal = M.Modal.init(element, {});
  }

  element = document.getElementById('style-settings');
  if(element) {
    styleModal = M.Modal.init(element, {
      onOpenEnd: function() {
        setTimeout(function() {
          Scribae.Color.updateWidth();
        }, 10);
      }
    });
  }
  //=========================================================
  //PREVIEW INIT
  Scribae.Global.initNewWindowLinks();
  Scribae.Global.initController();
  Scribae.Global.initIndexTable({});
  Scribae.Global.updateIndexTable();
  //Image
  Scribae.Preview.Image.init();
  Scribae.Preview.Edit.init();
  //Colors
  Scribae.Color.initFormImput();
  //Scribae.Preview.Edit.update();
  Scribae.Preview.Component.init();
  Scribae.Preview.Component.fit();
  //Terminal triggers
  Scribae.Terminal.triggers.preview.run = function() {
    Scribae.log(Scribae.LOG_TRACE, "website:preview:run");
    var links = $('.preview-link');
    links.parent().removeClass('hide');        
  }
  Scribae.Terminal.triggers.preview.stop = function() {
    Scribae.log(Scribae.LOG_TRACE, "website:preview:stop");
    var links = $('.preview-link');
    links.parent().addClass('hide');        
  }
  Scribae.Terminal.triggers.preview.update = function(enlapsed) {
    Scribae.log(Scribae.LOG_TRACE, "preview update: "+ enlapsed);
  }
  Scribae.Terminal.triggers.preview.error = function(error) {
    Scribae.log(Scribae.LOG_TRACE, "preview update: "+ error);
  }
  //Git
  gitPreloader = new Scribae.UI.Preloader('#git-preloader');
  Scribae.Terminal.triggers.git.create = function() {
     gitPreloader.show(I18n.t('preview.ui.create'));
  }
  Scribae.Terminal.triggers.git.created = function() {
    gitPreloader.hide(I18n.t('preview.ui.created'));
  }
  Scribae.Terminal.triggers.git.push = function() {
    gitPreloader.show(I18n.t('preview.ui.push'));
  }
  Scribae.Terminal.triggers.git.pushed = function() {
    gitPreloader.show(I18n.t('preview.ui.pushed'));
  }
  var silent = true;
  Scribae.Terminal.init(silent);
  //=========================================================
  //COMPS ENABLE TRIGGER
  $('#comp-show-form input[type=checkbox]').change(function () {
    console.log(this);
    $('#comp-show-form').submit();
  });
  //=========================================================
  //FORM UPDATE
  $('#preview-form').on('ajax:success', function(event, xhr, status, error) {
    console.log('preview-form ajax:sucess!');
    setTimeout(function(){
      Scribae.Preview.Edit.update();
    }, 200);
  });
  
  $('#settings-form').on('ajax:success', function(event, xhr, status, error) {
    console.log('settings-form ajax:sucess!');
    setTimeout(function(){
      
    }, 200);
  });
  
  $('#comp-show-form').on('ajax:success', function(event, xhr, status, error) {
    console.log('comp-show-form ajax:sucess!');
    setTimeout(function(){
      Scribae.Preview.Component.update();
    }, 200);
  });

  $('#style-form').on('ajax:success', function(event, xhr, status, error) {
    console.log('style-form ajax:sucess!');
    setTimeout(function(){
      styleModal.close();
    }, 100);
  });
  //=========================================================
  //UPDATE

  //Update on resize
  $(window).resize(function() {
    Scribae.Preview.Edit.update();
  });
  
});


  

    

