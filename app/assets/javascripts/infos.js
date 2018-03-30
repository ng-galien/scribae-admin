
$(document).ready(function(){  
  Scribae.log(Scribae.LOG_DEBUG, 'infos -> ready');
  //Main
  Scribae.Global.initController();
  //Table
  Scribae.Global.initIndexTable();
  Scribae.Global.updateIndexTable();
  //Index sorter
  Scribae.Sortable.init();
  //Image
  Scribae.Image.initGallery();
  //Editor
  Scribae.Editor.init();
});