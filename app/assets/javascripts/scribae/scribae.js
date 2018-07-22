
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
  LOG_DEBUG: 12,
  LOG_TRACE: 40,
  LOG_INFO: 50,
  LOG_NONE: 100,
  
  log: function(level, msg) {
    if(level) {
      if(level >= Scribae.LOG_LEVEL) {
        console.log(msg);
      }
    }
  },
  Channel: {
    connected: function(channel, type, id) {},
    disconnected: function(channel, type, id) {},
    received: function(channel, type, id, data) {},
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
  tocMenu: undefined,
  sortableModal: undefined
};

Scribae.Global.initController = function() {
  Scribae.Global.navbar = $('#app-navbar');
  var element = document.getElementById('create-modal');
  if(element) {
    Scribae.Global.createModal = M.Modal.init(element, {});
    $('.wait').hide();
    $('#create-form-container form').on('submit', function() {
      $('#create-form-container').hide();
      $('.wait').show();
    }); 
    $('#create-form-container form').on('ajax:success', function() {
      Scribae.Global.initNewWindowLinks();
    }); 
  }
  
  element = document.getElementById('sortable-modal');
  if(element) {
    Scribae.Global.sortableModal = M.Modal.init(element, {});
  }
  element = document.getElementById('toc-menu');
  if(element) {
    Scribae.Global.tocMenu = M.FloatingActionButton.init(element, {
      direction: 'bottom',
      hoverEnabled: false,
      toolbarEnabled: false
    });
  }
  $('.tooltipped').tooltip();
  $('.materialboxed').materialbox();
  M.updateTextFields();
}

/**
 * Make index table sortable
 */
Scribae.Global.initIndexTable = function(options) {
  Scribae.log(Scribae.LOG_DEBUG, 'Scribae.Global.initIndexTable');
  $("#index-table").tablesorter(options);  
}

/**
 * Update index table, show when not empty, trig update
 */
Scribae.Global.updateIndexTable = function() {
  Scribae.log(Scribae.LOG_DEBUG, 'Scribae.Global.updateIndexTable');
  var tableSize = $("#index-table td").length;
  if (tableSize > 0) {
    $('.empty-index-table').css('display', 'none');
    $("#index-table").css('opacity', 1);
    $("#index-table").trigger("updateAll");
    //
  } else {
    $('.empty-index-table').css('display', 'block');
    $("#index-table").css('opacity', 0);
  }
}

Scribae.Global.updateIndexPage = function(sortable) {
  
  if(Scribae.Global.createModal.isOpen) {
    //Close modal and reset display
    Scribae.Global.createModal.close();
    $('#create-form-container').show();
    $('.wait').hide();
    //Reset create text field
    var inputs = $("input[type='text']");
    inputs.val('');
    M.updateTextFields();
  }
  Scribae.Global.updateIndexTable();
  if(sortable) {
    Scribae.Sortable.init();
  }
}

Scribae.Global.suscribe = function() {
  $('.channel').each(function(){
    var type = $(this).attr('data-type');
    var id = $(this).attr('data-id');
    var channel = $(this).attr('data-channel');
    Scribae.log(Scribae.LOG_DEBUG, `susbcribe to => suscription:${channel}:${type}:${id}`);
    App.cable.subscriptions.create(
      {
        channel: channel,
        loggable_type: type,
        loggable_id: parseInt(id),
      },
      {
        connected: function() {
          Scribae.log(Scribae.LOG_DEBUG, `suscription:${channel}:${type}:${id}:connected`);
          Scribae.Channel.connected(channel, type, id);
        },
        disconnected: function() {
          Scribae.log(Scribae.LOG_DEBUG, `suscription:${channel}:${type}:${id}:disconnected`);
          Scribae.Channel.disconnected(channel, type, id);
        },
        received: function(data) {
          Scribae.log(Scribae.LOG_DEBUG, `suscription:${channel}:${type}:${id}:received:${data}`);
          Scribae.Channel.received(channel, type, id, data);
        }
      }
    );
  });
}
Scribae.Global.initNewWindowLinks = function() {
  $('.new-window').click(function() {
    var width = window.innerWidth * 0.66 ;
    // define the height in
    var height = width * window.innerHeight / window.innerWidth ;
    // Ratio the hight to the width as the user screen ratio
    window.open(this.href , '_blank', 'width=' + width + ', height=' + height + ', top=' + ((window.innerHeight - height) / 2) + ', left=' + ((window.innerWidth - width) / 2));

});
}
