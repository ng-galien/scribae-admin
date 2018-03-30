
function getActualDate() {
  var date = new Date();
  var val = $('#article_date_1i').val();
  date.setFullYear(parseInt(val));
  val = $('#article_date_2i').val();
  date.setMonth(parseInt(val)-1);
  val = $('#article_date_3i').val();
  date.setDate(parseInt(val));
  return date;
}
function getActualTime() {
  var res = "";
  res = $('#article_date_4i').val();
  res += ':';
  res += $('#article_date_5i').val();
  return res;
}
function initDatePicker() {
  var date = getActualDate();
  console.log(date);
  var element = document.querySelector('#input_text_article_date');
  var options = {
    format: "dd mmmm yyyy",
    defaultDate: date,
    setDefaultDate: true
  }
  var articleDatePicker = M.Datepicker.init(element, options);
  $('#input_text_article_date').change(function(){
      //console.log('Date picker change');
      //console.log(articleTimePicker.date);
      Scribae.Time.updateDate(articleDatePicker.date, 'article_date')
  });
  
  articleDatePicker.setDate(date);
  $('#input_text_article_date').val(articleDatePicker.toString());
}
function initTimePicker() {
  var time = getActualTime();
  console.log(time);
  var element = document.querySelector('#input_text_article_time');
  var options = {
    twelveHour: false,
    defaultTime: time,
  }
  var articleTimePicker = M.Timepicker.init(element, options);
  $('#input_text_article_time').change(function(){
      //console.log('Time picker change');
      //console.log(articleTimePicker.date);
      Scribae.Time.updateTime(articleTimePicker.time, 'article_date')
  });
  $('#input_text_article_time').val(time);
}


$(document).ready(function() {
    
  console.log('articles -> ready');
  //Index page
  Scribae.Global.initController();
  //Table
  
  Scribae.Global.initIndexTable({});
  Scribae.Global.updateIndexTable();
  
  //Images
  Scribae.Image.initMain();
  Scribae.Image.initGallery();
  //Editor
  Scribae.Editor.init();
  //Dates
  if($("#input_text_article_date").length > 0) {
    initTimePicker();
    initDatePicker();
  }
});