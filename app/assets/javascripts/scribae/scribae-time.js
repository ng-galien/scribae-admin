var Scribae = Scribae || {};

Scribae.Time = Scribae.Time || {
  navbar: undefined,
  createModal: undefined,
};


Scribae.Time.updateDate = function(date, select_id) {
  Scribae.log(SCRIBAE_LOG_FUNCTION, "Scribae:Form=>updateDate()");
  Scribae.Time.updateDateItem(date.getFullYear(), select_id, '_1i');
  Scribae.Time.updateDateItem(date.getMonth()+1, select_id, '_2i');
  Scribae.Time.updateDateItem(date.getDate(), select_id, '_3i');
}
Scribae.Time.updateTime = function(time, select_id) {
  Scribae.log(SCRIBAE_LOG_FUNCTION, "Scribae:Form=>updateTime()");
  var arr = time.split(':');

  Scribae.Time.updateDateItem(parseInt(arr[0]), select_id, '_4i');
  Scribae.Time.updateDateItem(parseInt(arr[1]), select_id, '_5i');

}
Scribae.Time.updateDateItem = function(val, select_id, item) {
  Scribae.log(SCRIBAE_LOG_FUNCTION, "Scribae:Form=>updateDateItem()");
  Scribae.log(SCRIBAE_LOG_FUNCTION, val);
  Scribae.log(SCRIBAE_LOG_FUNCTION, select_id);
  Scribae.log(SCRIBAE_LOG_FUNCTION, item);
  var y_select = '#' + select_id + item;
  //console.log(date.getFullYear());
  var y_filter = '[value=' + val + ']';
  var y_opt = $(y_select + ' option'+ y_filter);
  if(y_opt.length < 1) {
    //console.log('Does not exists');
    $(y_select).append($("<option></option>")
      .attr("value",val)
      .text(val));
  }
  /*$(y_select+' option')
    .removeAttr('selected')
    .filter(y_filter)
      .attr('selected', true);
  $(y_select).change();*/
  $(y_select).val(val);
}