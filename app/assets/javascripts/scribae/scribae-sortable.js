var Scribae = Scribae || {};

Scribae.Sortable = Scribae.Sortable || {
  modal: undefined
};

Scribae.Sortable.init = function() {
  var element = document.getElementById('sortable-modal');
  if(element) {
    Scribae.Sortable.modal = M.Modal.init(element, {});
  }
  $( "#sortable-list" ).sortable({
    forceHelperSize: true,
    cursor: "move",
    axis: "y",
    scroll: true,
    update: function (event, ui) {
      var nestedId = $('[data-nested]').attr('data-nested');
      var list = $('.sortable-list-id');
      var size = list.length;
      list.each(function(idx, item){
        var id = $(item).attr('data-value');
        var inputId = "website_" + nestedId + "_attributes_" + id + "_pos";
        var input = $('#'+inputId);
        input.attr('value', '' + (size - idx));
      });
      $('#sortable-form').submit();
    }
  });
  $("#sortable-form").on("ajax:success", function(e, data, status, xhr){
    console.log('sortable update success');
    Scribae.Global.updateIndexTable();
  }).on( "ajax:error", function(e, xhr, status, error) {
    console.log('sortable update error');
  });
    
}