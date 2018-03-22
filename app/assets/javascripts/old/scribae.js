SCRIBAE_LOG_ALL = 0;
SCRIBAE_LOG_FUNCTION = 5;
SCRIBAE_LOG_DEBUG = 10;
SCRIBAE_LOG_TRACE = 20;

SCRIBAE_LOG_DEFAULT = 5;

var Scribae = Scribae || {
  LOG_LEVEL: SCRIBAE_LOG_DEFAULT
};

Scribae.Home = Scribae.Home || {};
Scribae.Form = Scribae.Form || {};



Scribae.log = function(level, msg){
  if(level >= Scribae.LOG_LEVEL)
    console.log(msg);
}

FORM_DEBUG = false;

function rgb2hex(rgb) {
  rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i);
  return (rgb && rgb.length === 4) ? "#" +
    ("0" + parseInt(rgb[1], 10).toString(16)).slice(-2) +
    ("0" + parseInt(rgb[2], 10).toString(16)).slice(-2) +
    ("0" + parseInt(rgb[3], 10).toString(16)).slice(-2) : '';
}

Scribae.init = function () {
  Scribae.log(SCRIBAE_LOG_FUNCTION, "Scribae=>init()");
  Scribae.initEditForm();
  Scribae.initEditable();
  Scribae.initComponents();
  //var token = PubSub.subscribe( 'iconselect', function(msg, data){
  //  console.log(msg);
  //  console.log(data);
  //});
  //Scribae.initDropZone();
  Scribae.initMarkdownEditor();
}

Scribae.update = function() {
  Scribae.log(SCRIBAE_LOG_FUNCTION, "Scribae=>update()");
  //Update wrapper icons
  Scribae.initEditForm();
  $('.edit-wrapper').each(function(){
    var item = $(this).children('.edit-item');
    var proxy = $(this).children('.edit-proxy');
    $(item).position({
      of: $(proxy),
      my: "right center",
      at: "left-10 center",
    });
  });
  //Update components icons
  $('.component').each(function(){
    iconField = $(this).children('.edit-icon').attr('data-field');
    icon = $(this).children("[data-value='"+iconField+"']").html();
    $(this).children('.edit-proxy i').html(icon);

    colorField = $(this).children('.edit-color').attr('data-field');
    color = $(this).children("[data-value='"+colorField+"']").html();
    $(this).children('.edit-proxy i').css('color', color);
  });
}

/**
 * 
 */
Scribae.initEditForm = function() {
  Scribae.log(SCRIBAE_LOG_FUNCTION, "Scribae=>initEditForm()");
  //$('.edit-helper input').hide();
  $('#form_container form').hide();
  $('#form_container input').hide();
}
/**
 * 
 * @param {*} params 
 */
Scribae.initEditable = function(params) {
  Scribae.log(SCRIBAE_LOG_FUNCTION, "Scribae=>initEditable()");
  $('.edit-item').hide();
  $('.edit-item > i').css('cursor', 'pointer');
  //$('.edit-item').css('opacity', '0.0');
  $('.editable .edit-wrapper').each(function(i, wrapper) {
    var fixed = $(wrapper).hasClass('fixed-edit');
    if(fixed) {
      Scribae.showEditIcon($(wrapper));
      $(wrapper).children('.edit-action')
        .off('click')
        .click(function() {
          Scribae.attachEditImput($(this));
      });
    } else {
      $(wrapper).off('mouseenter');
      $(wrapper).mouseenter(function(){
        if($(this).is(':animated')) {
          return;
        }
        //console.log('enter field');
        Scribae.showEditIcon(this);
        $(this).children('.edit-action')
          .off('click')
          .click(function() {
            Scribae.attachEditImput($(this));
        });
    
      });
      //Leave from field zone
      $(wrapper).off('mouseleave');
      $(wrapper).mouseleave(function(){
        if($(this).is(':animated')) {
          return;
        }
        //console.log('exit field');
        Scribae.hideEditIcon(this)
      });    
    }
  }); 
}

//Attach icon to proxy
Scribae.attachToProxy = function (el, proxy, wrapper) {
  if (proxy.css('opacity') == 0) {
    return
  }
  //console.log('enter field');
  //show the item
  $(wrapper).animate({
    padding: "0px 0px 0px 1rem"
  }, 100, function () {
    $(el).css('opacity', 0).show().fadeTo('slow', 1);
    //position
    $(el).position({
      of: $(proxy),
      my: "right center",
      at: "left-5 center",
    });
  });
}
//Show 
Scribae.showEditIcon = function (wrapper) {
  var item = $(wrapper).children('.edit-item');
  var proxy = $(wrapper).children('.edit-proxy');
  Scribae.attachToProxy(item, proxy, wrapper);
}
//
Scribae.detachFromProxy = function (el, wrapper, animate) {
  $(wrapper).animate({
    padding: "0px 0px 0px 0px"
  }, animate, function () {

  });
  $(el).hide();
}
//hide
Scribae.hideEditIcon = function (wrapper) {
  var item = $(wrapper).children('.edit-item');
  Scribae.detachFromProxy(item, wrapper, 200);
}

//Componnet init sortable
Scribae.sortCompnent = function () {
  $('.sortable-handle').css('cursor', 'ew-resize');
  $('.component-container').sortable({
    forceHelperSize: true,
    cursor: "move",
    axis: "x",
    scroll: false,
    //containment: $(''),
    handle: ".sortable-handle",
    update: function (event, ui) {
      console.log('sort updated');
      $('.component-pos').each(function(idx, item){
        var attr = $(this).attr('data-field');
        var input = $('#'+attr);
        input.attr('value', ''+idx);
        $(this).html(''+idx);
        console.log(attr + '=>' +idx);
      });
      $('#website_form').submit();
      //console.log(ui);
    },
    start: function (event, ui) {
      //console.log('sort started');
      $('.edit-component').hide();
      $(ui.item).css('background-color', 'orange');
      $(ui.item).find('.sortable-handle span')
        .css('border-color', 'orange');
    },
    stop: function (event, ui) {
      //console.log('sort stopped');
      //console.log(ui);
      $(ui.item).css('background-color', 'white');
      $(ui.item).find('.sortable-handle span')
        .css('border-color', 'white');
      //$(ui.item).find('.edit-component')
      //  .show();
    },
  })
}

Scribae.initComponents = function() {

  Scribae.sortCompnent();

  $('.component-icon').off('click').click(function(){

  });
  $('.edit-component').hide();
  $('.edit-component > i').css('cursor', 'pointer');
  
  $('.component').each(function(){

    $(this).mouseenter(function(){

      //console.log('enter item');
      var item = $(this).find('.edit-component');
      $(item).show();
      $(item).position({
        of: $(this).find('.component-item'),
        my: "left top",
        at: "left+5 top+5",
      });
      $(item).off('click');

      $(item).click(function() {

        var comp = $(this).closest('.component');
        var other = $(comp).siblings('.component');
        var clazzs = $(comp).attr('class');
        var regex = /s\d/
        var test = clazzs.match(/s\d/);
        var colClazz = test ? test[0]: test;
        test = clazzs.match(/offset-s\d/);
        var offClazz = test ? test[0]: test;
        console.log('col: '+colClazz+', offset: '+offClazz);

        if(offClazz) {
          //Return form edit state
          other.each(function(idx, oComp){
            $(oComp)
              .css('opacity', 0)
              .show()
              .fadeTo('slow', 1);
          });
          $(comp).find('.edit-wrapper').each(function(i, el){
            Scribae.hideEditIcon(el)
          })
          console.log('remove classes: '+colClazz+', '+offClazz);
          $(comp)
            .css('opacity', 0)
            .removeClass(colClazz)
            .removeClass(offClazz)
            .addClass('s3')
            .fadeTo('slow', 1, function(){
              
            });
          $('.sortable-handle').show();
        } else {
          //Go to edit state
          $('.sortable-handle').hide();
                  
          other.each(function(idx, oComp){
            $(oComp).hide();
          });
          console.log('remove classes: '+colClazz);
          $(comp)
            .css('opacity', 0)
            .removeClass(colClazz)
            .addClass('s6')
            .addClass('offset-s3')
            .fadeTo('slow', 1, function(){
              $(comp).find('.edit-wrapper').each(function(i, el){
                Scribae.showEditIcon(el);
              });
            });
          $($(comp).find('.edit-component')).position({
            of: $(comp).find('.component-item'),
            my: "left top",
            at: "left+5 top+5",
          });
          $(comp).find('.edit-action')
            .off('click').click(function(){
            Scribae.attachEditImput($(this), true);
          });

        }
      })
    });
    $(this).mouseleave(function(){
      //console.log('exit item');
      $(this).find('.edit-component').hide();
      
    });
  })
}

/**
 * item: edit-item which send the action
 * initialState: redo the previous wrapper and item state
 */
Scribae.attachEditImput = function(item, initialState) {
  
  //Type
  var isText = $(item).hasClass('edit-text');
  var isColor = $(item).hasClass('edit-color');
  var isIcon = $(item).hasClass('edit-icon');
  var isImage = $(item).hasClass('edit-image');
  //Elements
  var formWrapper = $(item).closest('.form-wrapper');
  var wrapper = $(item).closest('.edit-wrapper');
  var proxy = $(wrapper).find('.edit-proxy');
  
  var attrId = $(item).attr('data-field');
  var valueEl = $(wrapper).find("[data-value='"+attrId+"']");
  var attrValue = $(valueEl).html();
  var proxy = $(wrapper).find(".edit-proxy");
  var input = $("input[id='"+attrId+"']");
  var form = $(input).closest('form');
  
  console.log(attrId);
  if(isText) {
    var inputs = $(form).children("input:visible");
    if(inputs.length > 0) {
      return;
    }
  }
  if(isColor) {
    Scribae.showColorPicker(item, input, form);
    return;
  } 
  if(isIcon) {
    Scribae.showIconPicker(item, input, form);
    return;
  }
 
  //configure input
  
  //size
  if(isText) {
    $(input).off('keyup');
    
    $(input).attr('value', attrValue)
      .attr('size', attrValue.length);
    $(input).css('font-size', $(valueEl).css('font-size'));
    //key event
    if(!initialState) {
      wrapper.css('padding', '0px');
      $(item).css("opacity", 0);
    }
    $(input).keyup(function (e) {
      //enter
      textVal = $(this).val();
      var enter = e.keyCode === 13;
      var exit = e.keyCode === 27;
      if (enter|| exit ) {
        console.log('enter or esc pressed');
        if( enter ) {
          console.log($(this).val());
          if(!FORM_DEBUG) {
            form.submit();
          } else {
            $(proxy).html(textVal);
          }
          
        }
        
        $(input).hide();
        $(form).appendTo($('#form_container'));
        
        $(proxy).fadeTo( "slow", 1 );
        if(!initialState) {   
          Scribae.showEditIcon();
        }
        $(item).fadeTo( "fast", 1 );
        $(item).position({
          of: $(proxy),
          my: "right center",
          at: "left-5 center",
        });
        //initWrapper(wrapper);
      }
      
      //sizing
      var size = parseInt($(this).attr('size')); 
      var chars = $(this).val().length; 
      if(chars > 10)
        //$(this).attr('size', chars-3); 
      $(form).position({
        of: $(proxy),
        my: "center center",
        at: "center center",
      });

    });
    
  } 


  //Append and show form
  $(form).appendTo($(formWrapper));
  $(form).show();
  

  $(input).css( "opacity", 0 )
  .fadeTo( "slow", 1 )
  .show();
  $(form).position({
    of: $(proxy),
    my: "center center",
    at: "center center",
  });

  if(isText) {
    $(item).fadeTo( "fast", 0 );
    $(proxy).css( "opacity", 0 );
  }
  $(input).focus();
  if(isImage) {
    console.log(Dropzone.options);
    input.hide();
  }

}

/**
 * 
 * @param {*} action 
 * @param {*} input 
 * @param {*} form 
 */
Scribae.showColorPicker = function (action, input, form) {

  var picker = $('#color_picker');
  wrapper = $(action).closest('.edit-wrapper');
  proxy = $(wrapper).children('.edit-proxy');
  $('#color_picker_container').minicolors({
    inline: true,
    format: 'hex',
    defaultValue: rgb2hex($(proxy).css('color')),
    change: function (value, opacity) {
      console.log(value);
      $(proxy).children('i').css('color', value);
    }
  });
  $('#color_picker .edit-action-validate')
    .css('cursor', 'pointer')
    .off('click').click(function () {
      $(input).attr('value', rgb2hex($(proxy).css('color')));
      if (!FORM_DEBUG)
        $(form).submit();
      $(picker).appendTo($('#picker_container'));
      $(picker).hide();
  });
  $('#color_picker .edit-action-cancel')
    .css('cursor', 'pointer')
    .off('click').click(function () {
      $(picker).appendTo($('#picker_container'));
      $(picker).hide();
  });
  $(picker).appendTo($(wrapper));
  $(picker).show();
  $(picker).position({
    of: $(proxy),
    my: "left top",
    at: "left bottom-24",
    //collision: "none" 
  });

}

/**
 * 
 * @param {*} action 
 * @param {*} input 
 * @param {*} form 
 */
Scribae.showIconPicker = function(action, input, form) {
  
  var picker = $('#icon_picker');
  wrapper = $(action).closest('.edit-wrapper');
  proxy = $(wrapper).children('.edit-proxy');
  $('.icon-picker-item').css('cursor', 'pointer')
  $('.icon-picker-item').off('click').click(function(){
    $(proxy).children('i').html($(this).html());
  });
  
  $('#icon_picker .edit-action-validate')
    .css('cursor', 'pointer')
    .off('click').click(function() {
      $(input).attr('value', $(proxy).children('i').html());
      if(!FORM_DEBUG)
        $(form).submit();
      $(picker).appendTo($('#picker_container'));
      $(picker).hide();
  });
  $('#icon_picker .edit-action-cancel')
  .css('cursor', 'pointer')
  .off('click').click(function() {
    $(picker).appendTo($('#picker_container'));
    $(picker).hide();
  });
  
  $(picker).appendTo($(wrapper));
  $(picker).show();
  $(picker).position({
    of: $(proxy),
    my: "center top",
    at: "center bottom-24",
    //collision: "none" 
  });

}

Scribae.initDropZone = function() {
  //Dropzone.autoDiscover = false;
  
  //$('#image_upload').addClass('dropzone');
  
  Dropzone.options.imgForm = {
  
    paramName: "upload",
    init: function() {
      this.on("drop", function(e) { 
        console.log("drop")
        console.log(e)
      });
      this.on("addedfile", function(file) { 
        console.log("added")
        console.log(file)
      });
      this.on("success", function(file, response) { 
        console.log('upload finished');
        file.previewElement.parentNode.removeChild(file.previewElement);
        $('.upload-helper').hide();
        $('.upload-helper').appendTo($('#edit-container'));
        eval(response);
      });
    }
  };
  Dropzone.discover();
}

Scribae.initMarkdownEditor = function() {
  Scribae.log(SCRIBAE_LOG_FUNCTION, "Scribae=>initMarkdownEditor()");
  $('.md-editor').each(function(){
    simpleMde = new SimpleMDE({
      element: $(this)[0],
      showIcons: []
    });
  });
}


