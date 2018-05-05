
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
  // Initialize Dropzone
  Scribae.log(Scribae.LOG_DEBUG, 'initdropzone');

  //Drop zone for main image
  element =  document.getElementById(IMG_MAIN_FORM_ID);
  if (typeof(element) != 'undefined' && element != null) {
    Scribae.Image.mainDrop = new Dropzone("#"+IMG_MAIN_FORM_ID);
    Scribae.Image.mainDrop.on("addedfile", function(file) {
      Scribae.log(Scribae.LOG_DEBUG, 'addedfile: ' + file);
    });
    Scribae.Image.mainDrop.on("success", function(file, response) {
      Scribae.log(Scribae.LOG_DEBUG, 'success: ' + file);

      $('#'+IMG_MAIN_PREVIEW_ID).attr('src', response.upload.m.url+'?v=' + new Date().getTime());
      if(Scribae.Image.mainModal) {
        Scribae.Image.mainModal.close();
      }
      file.previewElement.remove(); 
      $('.dropzone').removeClass('dz-started');
    });
    Scribae.Image.mainDrop.on("complete", function(file) {
      console.log('complete: ' + file);
    });
  }
}

Scribae.Image.initGallery = function(reload) {
  Scribae.Image.reloadDropZone = reload;
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

      Scribae.log(Scribae.LOG_DEBUG, 'image added to Gallery: ' + file);
      eval(response);
      file.previewElement.remove(); 
      $('.dropzone').removeClass('dz-started');
    });
    Scribae.Image.galleryDrop.on("complete", function(file) {
      console.log('complete: ' + file);
    });
    $('#gallery-insert').click(function(){
      var align = 'c';
      var size = 50;
      Scribae.Image.insertImage(size, align);
    });
    $('#gallery-return').click(function(){
      Scribae.Image.displaySelectedImage(false);
    });
  }
}



Scribae.Image.displaySelectedImage = function(selected) {
  if(selected) {
    $('#new-upload-container').hide();
    $('#gallery-content').hide();
    $('#gallery-detail').show();
  } else {
    $('#new-upload-container').show();
    $('#gallery-content').show();
    $('#gallery-detail').hide();
  }
}

Scribae.Image.selectGallery = function (selection) {
  Scribae.Image.gallerySelection = selection;
  console.log("selectGallery");
  console.log(selection);
  $('#galery-preview').attr('src', selection.url);
  Scribae.Image.displaySelectedImage(true);
}

Scribae.Image.insertImage = function(size, align) {
  var sel = Scribae.Image.gallerySelection;
  var editor = Scribae.Editor.editor;
  if(sel && editor) {
    var url = sel.url;
    var mdi = '![{s:'+size+',a:\"'+ align +'\",o:""}]('+url+')';
    var doc = editor.codemirror.getDoc();
    var cursor = doc.getCursor();
    doc.replaceRange(mdi, cursor);
    Scribae.Image.displaySelectedImage(false);
    Scribae.Image.galleryModal.close();
  }
  
  
  
}


