
$(document).ready(function(){  
  Scribae.log(Scribae.LOG_DEBUG, 'themes -> ready');
  //Main
  Scribae.Global.initController();
  //Table
  Scribae.Global.initIndexTable();
  Scribae.Global.updateIndexTable();
  //Index sorter
  Scribae.Sortable.init();
  //Images
  Scribae.Image.initMain();
  Scribae.Image.initGallery();
  //Editor
  Scribae.Editor.init();
  
});
