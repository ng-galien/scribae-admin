/*Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/

$(document).ready(function(){
  console.log('websites -> ready');
  //=========================================================
  //MATERIALIZE INIT
  $('.parallax').parallax();
  var element = document.getElementById('website-settings');
  if(element) {
    M.Modal.init(element, {});
  }
  //=========================================================
  //PREVIEW INIT
  Scribae.Global.initController();
  Scribae.Global.initIndexListTable({});
  //Image
  Scribae.Preview.Image.init();
  Scribae.Preview.Edit.init();
  //Scribae.Preview.Edit.update();
  Scribae.Preview.Component.init();
  Scribae.Preview.Component.fit();
  //=========================================================
  //FORM TRIG
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
  //WINDOW UPDATE
  $(window).resize(function() {
    Scribae.Preview.Edit.update();
  });

});

  

    

