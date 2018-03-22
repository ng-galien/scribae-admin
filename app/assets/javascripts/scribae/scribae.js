function rgb2hex(rgb) {
  rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i);
  return (rgb && rgb.length === 4) ? "#" +
    ("0" + parseInt(rgb[1], 10).toString(16)).slice(-2) +
    ("0" + parseInt(rgb[2], 10).toString(16)).slice(-2) +
    ("0" + parseInt(rgb[3], 10).toString(16)).slice(-2) : '';
}

String.prototype.width = function(font) {
  var f = font || '12px arial',
      o = $('<div></div>')
            .text(this)
            .css({'position': 'absolute', 'float': 'left', 'white-space': 'nowrap', 'visibility': 'hidden', 'font': f})
            .appendTo($('body')),
      w = o.width();
  o.remove();
  return w;
}

var Scribae = Scribae || {
  LOG_LEVEL: 0,
  LOG_ALL: 10,
  LOG_FUNCTION: 20,
  LOG_DEBUG: 30,
  LOG_TRACE: 40,
  LOG_INFO: 50,
  LOG_NONE: 100,
  log: function(level, msg) {
    if(level) {
      if(level > Scribae.LOG_LEVEL) {
        console.log(msg);
      }
    }
  }
}

Scribae.Global = Scribae.Global || {
  RESP_IMG: [
    ['xl', 1600],
    ['l', 1200],
    ['m', 900],
    ['s', 600],
    ['xs', 200],
  ],
  navbar: undefined,
  createModal: undefined,

};

Scribae.Global.initController = function() {
  Scribae.Global.navbar = $('#app-navbar');
  var element = document.querySelector('#create-modal');
  if(element) {
    Scribae.Global.createModal = M.Modal.init(element, {});
  }
  $('.tooltipped').tooltip();
  M.updateTextFields();
}

Scribae.Global.initIndexListTable = function(options) {
  $("#list-index-table").tablesorter(options);
}

