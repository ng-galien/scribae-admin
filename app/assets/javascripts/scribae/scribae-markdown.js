var Scribae = Scribae || {};

Scribae.Markdown = Scribae.Markdown || {
};

Scribae.Markdown.decorateMarkdown = function(container) {
  $(container).find('img').each(function () {

    //$(this).parent().css("text-align", "center")
    $(this).addClass("responsive-img");
    //$(this).addClass("");
    //$(this).addClass("center");
    /*$(this).load(function () { 
        //
        console.log('resize md image');
        $(this).data('width', $(this).width()); 
    });*/
    //$(this).data('width', $(this).width());
    //console.log($(this))
    
  });
  $(container).find('p').addClass("flow-text");
  $(container).find('table').addClass("striped");
  $(container).find('table').css('max-width', '90%');
}

