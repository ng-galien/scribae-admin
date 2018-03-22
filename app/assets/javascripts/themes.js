
$(document).ready(function(){  
  console.log('themes -> ready');
  Scribae.Global.initController();
  Scribae.Image.initMain();
  Scribae.Image.initGallery();
  Scribae.Editor.init();
  Scribae.Global.initIndexListTable({
    
  });
});
