function initMenu() {
  $(".sidenav").sidenav({ });
  $(".dropdown-button").dropdown();
}

function setMDContent() {
  $('.md-content').find('img').each(function () {
      if(Document.MD_DOC) {
          assetPath = Document.MD_ASSET + "/" + $(this).attr("alt");
          $(this).attr("src", assetPath);   
      }
      $(this).parent().css("text-align", "center")
      $(this).addClass("responsive-img");
      $(this).addClass("center");
      /*$(this).load(function () { 
          //
          console.log('resize md image');
          $(this).data('width', $(this).width()); 
      });*/
      $(this).data('width', $(this).width());
      console.log($(this))
      
  });
  $('.md-content').find('p').addClass("flow-text");
  $('.md-content').find('table').addClass("bordered");
  $('.md-content').find('table').addClass("");
}
$(document).ready(function () {
  console.log("document loaded");
  initMenu();
  $('.parallax').parallax();
  $('.fixed-height-card').matchHeight({
      byRow: true,
      property: 'height',
      target: null,
      remove: true
  });
  $('.fixed-height').matchHeight({
      byRow: true,
      property: 'height',
      target: null,
      remove: false
  });
  $('.home-item-small-row').matchHeight({
      byRow: true,
      property: 'height',
      target: null,
      remove: false
  });
  
  $('.scrollspy').scrollSpy();
  
  $('.paginator-fixed').pushpin({
      offset: 70
  });
  $('.fixed-pos').pushpin({
      offset: 50
  });
  $('.lazy').lazy({
      afterLoad: function(element) {
          //$(element).addClass('materialboxed');
          //$(element).parents('.col').removeClass('hide');
          //$(window).trigger('resize');
      },
      onFinishedAll: function() {
          console.log('finished loading all images');
          $('.fixed-height-lazy').matchHeight({
              byRow: true,
              property: 'height',
              target: null,
              remove: false
          });
      }
  });
  setMDContent();
});