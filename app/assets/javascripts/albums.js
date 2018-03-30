
var galleryHeight;


function updateHeight() {
  galleryHeight = $('#gallery-content').height();
}

function initSortableGallery() {
  updateHeight();
  $('#gallery-content').sortable({
    cursor: "move",
    scroll: true,
    forcePlaceholderSize: true,
    helper: function(event, ui){
      var $clone =  $(ui).clone();
      $clone .css('position','absolute');
      return $clone.get(0);
    },
    start: function (event, ui) {       
      console.log(galleryHeight);
      $('#gallery-content').css('min-height', galleryHeight+'px');
    },
    stop: function (event, ui) { 
      $('#gallery-content').css('min-height', '');
    },
    update: function (event, ui) {
      
      var list = $('#gallery-content').children();
      var size = list.length;
      list.each(function(idx, item) {
        var id = $(item).attr('data-id');
        var inputId = "album_images_attributes_" + id + "_pos";
        var input = $('#'+inputId);
        input.attr('value', '' + (size - idx));
      });
      $('#sortable-gallery-form').submit();
    }
  });
  $("#sortable-gallery-form").on("ajax:success", function(e, data, status, xhr){
    console.log('sortable update success');
    updateHeight();
    configureDelete();
    //updateUploadForm();
  }).on( "ajax:error", function(e, xhr, status, error) {
    console.log('sortable update error');
  });
}

$(document).ready(function(){  

  Scribae.log(Scribae.LOG_DEBUG, 'albums -> ready');
  //Main
  Scribae.Global.initController();
  //Table
  Scribae.Global.initIndexTable();
  Scribae.Global.updateIndexTable();
  //Index sorter
  Scribae.Sortable.init();
  //Image
  Scribae.Image.initMain();
  Scribae.Image.initGallery();
  initSortableGallery();
});