var Scribae = Scribae || {};

Scribae.Preview = Scribae.Preview ||{}
//Editor form
Scribae.Preview.Edit = {

  editable: {},
  
  init: function(params) {
    //Scribae.log(SCRIBAE_LOG_FUNCTION, "Scribae=>initEditable()");
    //$('.edit-item').hide();
    $('#form-container form').hide();
    $('#form-container input').hide();

    //$('.edit-item > i').css('cursor', 'pointer');
    $('.edit-item > i').each(function(i, item) {
      $(item)
        .css('width', $(item).height()+'px')
        .css('cursor', 'pointer');
    });
    //$(editObj.action).css('width', $(editObj.action).height()+'px');
    //$('.edit-item').css('opacity', '0.0');
    $('.editable').each(function(i, editable) {
      var wrapper = $(editable).find('.edit-wrapper');
      var fixed = $(wrapper).hasClass('fixed-edit');
      var item = $(editable).find('.edit-item');
      var proxy = $(editable).find(".edit-proxy");
      Scribae.Preview.Edit.alignIcon(item, proxy);
      if(fixed) {
        $(editable).find('.edit-action')
          .off('click')
          .click(function() {
            var wrapper = $(this).parents('.edit-wrapper');
            var item = wrapper.find('.edit-item');
            var proxy = wrapper.find('.edit-proxy');
            var attrId = $(item).attr('data-field');
            var value = $(wrapper).find("[data-value='"+attrId+"']");
            var input = $("input[id='"+attrId+"']");
            var fixed = $(wrapper).hasClass('fixed-edit');
            var action = $(this);
            Scribae.Preview.Edit.attach(
                  wrapper, item, 
                  action, proxy, 
                  input, value, fixed);
        });
      } else {

        wrapper.off('mouseenter')
          .mouseenter(function(){
            if($(this).is(':animated')) {
              return;
            }
            $(this).find('.edit-action')
              .off('click')
              .click(function() {
                var wrapper = $(this).parents('.edit-wrapper');
                var item = wrapper.find('.edit-item');
                var proxy = wrapper.find('.edit-proxy');
                var attrId = $(item).attr('data-field');
                var value = $(wrapper).find("[data-value='"+attrId+"']");
                var input = $("input[id='"+attrId+"']");
                var fixed = $(wrapper).hasClass('fixed-edit');
                var action = $(this);
                Scribae.Preview.Edit.attach(
                  wrapper, item, 
                  action, proxy, 
                  input, value, fixed)
            });
      
        });
        //Leave from field zone
        wrapper.off('mouseleave')
          .mouseleave(function(){
          if($(this).is(':animated')) {
            return;
          }
          //console.log('exit field');
          //Scribae.Preview.Edit.hideEditIcon(this)
        });    
      }
    }); 
  },

  alignIcon: function(item, proxy) {
    $(item).position({
      of: $(proxy),
      my: "left center",
      at: "right+10 center",
    });
  },

  update: function() {
    $('.editable').each(function(){
      var item = $(this).find('.edit-item');
      var proxy = $(this).find(".edit-proxy");
      Scribae.Preview.Edit.alignIcon(item, proxy);
    }); 
  },
  //=====================================================================
  //ATTACH THE INPUT TO THE COMPONENT
  attach: function(wrapper, item, action, proxy, input, value, fixed) {
    //Type
    var isText = $(action).hasClass('edit-text');
    var isColor = $(action).hasClass('edit-color');
    var isIcon = $(action).hasClass('edit-icon');
    var isImage = $(action).hasClass('edit-image');
    //Elements
    
    var form = $(input).closest('form');
    
    //console.log(attrId);
    if(isText) {
      var inputs = $(form).children("input:visible");
      if(inputs.length > 0) {
        return;
      }
    }
    if(isColor) {
      Scribae.Preview.Picker.showColorPicker(item, input, form);
      return;
    } 
    if(isIcon) {
      Scribae.Preview.Picker.showIconPicker(item, input, form);
      return;
    }
   
    //CONFIGURE INPUT
    
    //size
    if(isText) {
      $(input).off('keyup');
      
      $(input).attr('value', value.html());

      $(input).css('font-size', $(value).css('font-size'));
      font = value.css('font');
      $(input).css('width', value.html().width(font)+20);
      
      if(!fixed) {
        wrapper.css('padding', '0px');
        $(item).css("opacity", 0);
      }
      //key event
      $(input).keyup(function (e) {
        
        textVal = $(this).val();
        var enter = e.keyCode === 13;
        var exit = e.keyCode === 27;
        //enter
        if (enter|| exit ) {
          console.log('enter or esc pressed');
          if( enter ) {
            form.submit();
          }
          $(input).hide();
          $(form).appendTo($('#form_container'));
          $(proxy).fadeTo( "slow", 1, function(){
            Scribae.Preview.Edit.alignIcon(item, proxy);
            $(item).fadeTo( "fast", 1 );
          });
          if(!fixed) {   
            Scribae.Preview.showEditIcon();
          }
          //initWrapper(wrapper);
        }
        //sizing
        $(input).css('width', textVal.width(font)+20);
        $(form).position({
          of: $(proxy),
          my: "center center",
          at: "center center",
        });
  
      });
      
    } 
    //Append and show form
    $(form).appendTo($(wrapper));
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
      //console.log(Dropzone.options);
      $(input).hide();
    }
  
  },
  detach: function (el, wrapper, animate) {
    $(wrapper).animate({
      padding: "0px 0px 0px 0px"
    }, animate, function () {

    });
    $(el).hide();
  }
}
//Picker
Scribae.Preview.Picker = {

  showColorPicker: function (action, input, form) {

    var picker = $('#color-picker');
    wrapper = $(action).closest('.edit-wrapper');
    proxy = $(wrapper).children('.edit-proxy');
    $('#color-picker-container').minicolors({
      inline: true,
      format: 'hex',
      defaultValue: rgb2hex($(proxy).css('color')),
      change: function (value, opacity) {
        console.log(value);
        $(proxy).children('i').css('color', value);
      }
    });
    $('#color-picker .edit-action-validate')
      .css('cursor', 'pointer')
      .off('click').click(function () {
        $(input).attr('value', rgb2hex($(proxy).css('color')));
        $(form).submit();
        $(picker).appendTo($('#picker-container'));
        $(picker).hide();
    });
    $('#color-picker .edit-action-cancel')
      .css('cursor', 'pointer')
      .off('click').click(function () {
        $(picker).appendTo($('#picker-container'));
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
  
  },
  showIconPicker: function(action, input, form) {
  
    var picker = $('#icon-picker');
    wrapper = $(action).closest('.edit-wrapper');
    proxy = $(wrapper).children('.edit-proxy');
    $('.icon-picker-item').css('cursor', 'pointer')
    $('.icon-picker-item').off('click').click(function(){
      $(proxy).children('i').html($(this).html());
    });
    
    $('#icon-picker .edit-action-validate')
      .css('cursor', 'pointer')
      .off('click').click(function() {
        $(input).attr('value', $(proxy).children('i').html());
        $(form).submit();
        $(picker).appendTo($('#picker-container'));
        $(picker).hide();
    });
    $('#icon-picker .edit-action-cancel')
    .css('cursor', 'pointer')
    .off('click').click(function() {
      $(picker).appendTo($('#picker-container'));
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
}
//Component
Scribae.Preview.Component = {
  //=====================================================================
  //UPDATE COMPONENTS
  update: function() {
    
    var size = 0;
    $('.comp-info').each(function() {
        if($(this).html()=='true') {
          size ++;
        }
    });
    console.log('size '+size);
    $('.component').each(function(i, el) {

      var showEl =  $(this).find('.comp-info');
      var isshow = showEl.html() == 'true';
      if(!isshow) {
        $(this).hide();
      } else {
        $(this).show();
        var clazzs = $(this).attr('class');
        var col = clazzs.match(/s\d/);
        if(col) {
          $(this).toggleClass(col[0]);
        }
        var off = clazzs.match(/offset-s\d/);
        if(off) {
          $(this).toggleClass(off[0]);
        }
        if(size < 4) {
          if(i == 0) {
            if(size==1)
              $(this).addClass('offset-s4');
            if(size==2)
              $(this).addClass('offset-s2');
          }
          $(this).addClass('s4');
        }
        if(size==4) {
          $(this).addClass('s3');
        }
        if(size==5) {
          $(this).addClass('s2');
          if(i == 0) {
            $(this).addClass('offset-s1');
          }
        }
        if(size>5) {
          $(this).addClass('s2');
        }
      }
    });
    Scribae.Preview.Component.fit();
  },

  fit: function(){
    $('.match-height-1').matchHeight({
      byRow: true,
      property: 'height',
      target: null,
      remove: false
    });  
    $('.match-height-2').matchHeight({
      byRow: true,
      property: 'height',
      target: null,
      remove: false
    }); 
  },
  //=====================================================================
  //INIT COMPONENTS
  /**
   * Init the components
   */
  init: function() {
    //Update and sort the components
    Scribae.Preview.Component.update();
    Scribae.Preview.Component.sort();
    //Configure the icon
    $('.edit-component').hide();
    $('.edit-component > i').css('cursor', 'pointer');
    //For each components
    $('.component').each(function(){
      //Hide all icons
      $(this).find('.edit-item').hide();
      //Mouse enter
      $(this).mouseenter(function(){
  
        //console.log('enter item');
        $(this).find('.edit-component')
        .show()
        .position({
          of: $(this).find('.component-item'),
          my: "left top",
          at: "left+5 top+5",
        })
        .off('click')
        .click(function() {
  
          var comp = $(this).closest('.component');
          var other = $(comp).siblings('.component');
          var clazzs = $(comp).attr('class');
          var regex = /s\d/;
          var test = clazzs.match(/s\d/);
          var colClazz = test ? test[0]: test;
          test = clazzs.match(/offset-s\d/);
          var offClazz = test ? test[0]: test;
          console.log('col: '+colClazz+', offset: '+offClazz);
  
          if(offClazz) {
            //Return form edit state
            other.each(function(idx, oComp){
              var showEl =  $(oComp).find('.comp-info');
              var isshow = showEl.html() == 'true';
              if(isshow) {
                $(oComp)
                .css('opacity', 0)
                .show()
                .fadeTo('slow', 1);
              }
            });
            $(comp).find('.edit-wrapper').each(function(){
              $(this).find('.edit-item')
                .css('opacity', 0)
                .hide();
            });
            Scribae.Preview.Component.update();
            $('.sortable-handle').show();
            //Scribae.Preview.Component.fit();
            //$('.edit-component').hide();
          } else {
            //Go to edit state
            $('.sortable-handle').hide();
                    
            other.each(function(idx, oComp){
              $(oComp).hide();
            });
            //console.log('remove classes: '+colClazz);
            $(comp)
              .css('opacity', 0)
              .removeClass(colClazz)
              .addClass('s6')
              .addClass('offset-s3')
              .fadeTo('slow', 1);
            //Shoy and move edit item
            $(comp).find('.edit-wrapper').each(function(){
              
              $(this).find('.edit-item')
                .css('opacity', 0)
                .show()
                .position({
                  of: $(this).find('.edit-proxy'),
                  my: "left center",
                  at: "right+10 center",
                }).fadeTo('slow', 1);
            });
              
            //Close icon
            $($(comp).find('.edit-component')).position({
              of: $(comp).find('.component-item'),
              my: "left top",
              at: "left+5 top+5",
            });
            //Action
            $(comp).find('.edit-action')
              .off('click')
              .click(function() {
              console.log('edit-action');
              var wrapper = $(this).parents('.edit-wrapper');
              var item;
              if($(this).hasClass('edit-item')) {
                item = $(this);
              } else {
                item = $(this).parents('.edit-item');
              }
              var proxy = wrapper.find('.edit-proxy');
              var id = item.attr('data-field');
              var input = $('input[id="'+id+'"]');
              var value = $('[data-value="'+id+'"]');
              var fixed = true;
              var action = $(this);
              Scribae.Preview.Edit.attach(wrapper, item, action, proxy, input, value, fixed);
            });
  
          }
        })
      });
      $(this).mouseleave(function(){
        //console.log('exit item');
        $(this).find('.edit-component').hide();
        
      });
    })
  },
  //=====================================================================
  //SORTING COMPONENTS
  sort: function () {
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
          var pos = '' + (idx + 1);
          input.attr('value', pos);
          $(this).html(pos);
          console.log(attr + '=>' + pos);
        });
        $('#preview-form').submit();
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
}
//Image
Scribae.Preview.Image = {
  imageModal: {}, 
  imageDrop: {},
  init: function() {
    ['top', 'bottom'].forEach(function(image) {
      var element = document.getElementById('image-'+image+'-modal');
      if(element) {
        Scribae.Preview.Image.imageModal[image] = M.Modal.init(element, {});
      }
      $('#image-'+image+'-trigger').click(function(){
        Scribae.Preview.Image.imageModal[image].open();
      });
      element = document.getElementById('image-'+image+'-form');
      if(element) {
        Scribae.Preview.Image.imageDrop[image] = new Dropzone('#image-'+image+'-form');
        Scribae.Preview.Image.imageDrop[image].on("addedfile", function(file) {
          console.log('addedfile: ' + file);
        });
        Scribae.Preview.Image.imageDrop[image].on("success", function(file, response) {
          //Set the picture srcset
          Scribae.Global.RESP_IMG.forEach(function(size){
            $('#'+image+'-src-'+size[0]).attr('srcset', response.upload[size[0]].url+'?v=' + new Date().getTime());
          });
          $('#'+image+'-src-default').attr('srcset', response.upload.url+'?v=' + new Date().getTime());
          Scribae.Preview.Image.imageModal[image].close();
        });
        Scribae.Preview.Image.imageDrop[image].on("complete", function(file) {
          console.log('complete: ' + file);
        });
      }
    });
  
  }
}