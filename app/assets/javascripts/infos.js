
$(document).ready(function(){  
  console.log('infos -> ready');
  Scribae.Global.initController();
  Scribae.Image.initGallery();
  Scribae.Editor.init();
  Scribae.Global.initIndexListTable({
    
  });
  //Scribae.Global.initIndexListTable({
  //  sortList: [
  //    [1, 0],
  //    [2, 0],
  //    [3, 0],
  //  ],
  //  sortForce: [[1, 0]]
  //});
});