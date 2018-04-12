/*Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/

//Modals
var settingsModal;
var gitModal;
var previewModal;

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
  console.log('websites -> ready');

  Scribae.Global.suscribe();
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
  element = document.getElementById('preview-settings');
  if(element) {
    previewModal = M.Modal.init(element, {});
  }
  //=========================================================
  //PREVIEW INIT
  Scribae.Global.initController();
  Scribae.Global.initIndexTable({});
  Scribae.Global.updateIndexTable();
  //Image
  Scribae.Preview.Image.init();
  Scribae.Preview.Edit.init();
  //Scribae.Preview.Edit.update();
  Scribae.Preview.Component.init();
  Scribae.Preview.Component.fit();
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

  //=========================================================
  //UPDATE

  //Update on resize
  $(window).resize(function() {
    Scribae.Preview.Edit.update();
  });
  //Timer for preview status
  //setInterval(function(){
  //  var url = $("#menu-container").find('[data-status]').attr('data-link');
  //  if(url && updateStatus) {
  //    $.ajax({
  //      url: url,
  //      data: {},
  //      contentType: 'application/json',
  //      dataType: 'text',
  //      success: checkStatus
  //    });
  //  }
  ////  }, 1000);
  //$('#terminal-link').click(function(){
  //  var id = $(this).attr('data-id');
  //  showTerminal(id)
  //});
});


  

    

