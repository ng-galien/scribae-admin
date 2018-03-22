
Dropzone.autoDiscover = false;

IMG_MAIN_FORM_ID = "image-main-form";
IMG_MAIN_PREVIEW_ID = "image-main-preview";
IMG_MAIN_MODAL_ID = "image-main-modal";
GALLERY_MODAL_ID = "gallery-modal";
GALLERY_FORM_ID = "gallery-form";

var Scribae = Scribae || {};

Scribae.Image = Scribae.Image || {
  mainModal: undefined,
  galleryModal: undefined,

  mainDrop: undefined,
  galleryDrop: undefined,
  
  gallerySelection: undefined,

};

Scribae.Image.initMain = function() {
  //Modal
  var element = document.querySelector('#'+IMG_MAIN_MODAL_ID);
  if(element) {
    Scribae.Image.mainModal = M.Modal.init(element, {});
  }
  //Dropzone
  console.log('initdropzone');
  element =  document.getElementById(IMG_MAIN_FORM_ID);
  if (typeof(element) != 'undefined' && element != null) {
    Scribae.Image.mainDrop = new Dropzone("#"+IMG_MAIN_FORM_ID);
    Scribae.Image.mainDrop.on("addedfile", function(file) {
      console.log('addedfile: ' + file);
    });
    Scribae.Image.mainDrop.on("success", function(file, response) {
      console.log('success: ' + file);
      console.log(response);
      $('#'+IMG_MAIN_PREVIEW_ID).attr('src', response.upload.xs.url+'?v=' + new Date().getTime());
      if(Scribae.Image.mainModal) {
        Scribae.Image.mainModal.close();
      }
      
    });
    Scribae.Image.mainDrop.on("complete", function(file) {
      console.log('complete: ' + file);
    });
  }
}

Scribae.Image.initGallery = function() {
  //Modal
  var element = document.querySelector('#'+GALLERY_MODAL_ID);
  if(element) {
    Scribae.Image.galleryModal = M.Modal.init(element, {});
    Scribae.Image.displaySelectedImage(false);
  }
  //Drop
  element =  document.getElementById(GALLERY_FORM_ID);
  if (typeof(element) != 'undefined' && element != null) {
    Scribae.Image.galleryDrop = new Dropzone("#"+GALLERY_FORM_ID);
    Scribae.Image.galleryDrop.on("addedfile", function(file) {
      console.log('addedfile: ' + file)
    });
    Scribae.Image.galleryDrop.on("success", function(file, response) {
      console.log('success: ' + file);
      console.log(response);
      eval(response);
      setTimeout(function() {
        $("#"+GALLERY_FORM_ID).find('div.dz-success').remove();
        $("#"+GALLERY_FORM_ID).find('div.dz-message').show();
      }, 500);
    });
    Scribae.Image.galleryDrop.on("complete", function(file) {
      console.log('complete: ' + file);
    });
    $('#galery-insert-large').click(function(){
      Scribae.Image.insertImage('m');
    });
    $('#galery-insert-medium').click(function(){
      Scribae.Image.insertImage('s');
    });
    $('#galery-insert-small').click(function(){
      Scribae.Image.insertImage('xs');
    });
    $('#galery-back').click(function(){
      Scribae.Image.displaySelectedImage(false);
    });
  }
}



Scribae.Image.displaySelectedImage = function(selected) {
  if(selected) {
    $('#gallery-upload').hide();
    $('#gallery-content').hide();
    $('#gallery-detail').show();
  } else {
    $('#gallery-upload').show();
    $('#gallery-content').show();
    $('#gallery-detail').hide();
  }
}

Scribae.Image.selectGallery = function (selection) {
  Scribae.Image.gallerySelection = selection;
  console.log("selectGallery");
  console.log(selection);
  $('#galery-preview').attr('src', selection.size.m);
  Scribae.Image.displaySelectedImage(true);
}

Scribae.Image.insertImage = function (size) {
  var sel = Scribae.Image.gallerySelection;
  var editor = Scribae.Editor.editor;
  if(sel && editor) {
    var id = sel.id;
    var url = sel.size[size];
    var mdi = '!['+id+']('+url+')';
    var doc = editor.codemirror.getDoc();
    var cursor = doc.getCursor();
    doc.replaceRange(mdi, cursor);
    Scribae.Image.displaySelectedImage(false);
    Scribae.Image.galleryModal.close();
  }
  
  
  
}


