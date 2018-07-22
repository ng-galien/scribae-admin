/**
 * Color picker utility function
 * Use an input field as a color picker
 * Main purpose is for resizing the input to it's parent size
 */
var Scribae = Scribae || {};

Scribae.Color = Scribae.Color || {
 
  className: undefined,

  /**
   * Init form inputs
   */
  initFormImput: function(className) {
    Scribae.Color.className = className || '.color-input';
    $(Scribae.Color.className).each(function(index, element){
      //console.log(element);
      $(element).find('input').minicolors();
    });
    //Scribae.Color.updateWidth();
  },

  /**
   * Resize
   */
  updateWidth: function() {
    $(Scribae.Color.className).each(function(index, element){
      var parent = $(element).closest('.color-container');
      var width = $(element).width();
      var height = $(element).height();
      Scribae.log(Scribae.LOG_DEBUG, 'update color imput size => '+ width+' x '+ height);
      child = $(element).find('.minicolors-swatch-color');
      if(child) {
        child.width(width);
        child.height(height);
      }
    });
  }
}