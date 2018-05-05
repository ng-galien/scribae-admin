var Scribae = Scribae || {};

Scribae.Color = Scribae.Color || {
 
  className: undefined,

  initFormImput: function(className) {
    Scribae.Color.className = className || '.color-input';
    $(Scribae.Color.className).each(function(index, element){
      //console.log(element);
      $(element).find('input').minicolors();
    });
    //Scribae.Color.updateWidth();
  },

  updateWidth: function() {
    $(Scribae.Color.className).each(function(index, element){
      var parent = $(element).closest('.color-container');
      //console.log(parent);
      var width = $(element).width();
      var height = $(element).height();
      console.log('update color imput size => '+ width+' x '+ height);
      child = $(element).find('.minicolors-swatch-color');
      if(child) {
        child.width(width);
        child.height(height);
      }
    });
  }
}