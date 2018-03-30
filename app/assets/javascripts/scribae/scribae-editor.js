EDITOR_CLASS = "mde-editor"

var Scribae = Scribae || {};

Scribae.Editor = Scribae.Editor || {
  observer: undefined,
  editor: undefined,
  simpleMDE: undefined,
  preview: undefined,
  openGalleryCallback: function() {
    console.log('must assign openGalleryCallback');
  }
};

Scribae.Editor.init = function(opt) {
  Scribae.Editor.observer = new MutationObserver(function() {
    //console.log('observed');
    Scribae.Markdown.decorateMarkdown('.editor-preview-active-side')
  });

  console.log('init MDE');
  var element = document.querySelector("."+EDITOR_CLASS);
  if(element) {
    Scribae.Editor.simpleMDE = new SimpleMDE({
      element: element,
      toolbar: [
        "bold", "italic", "strikethrough",
        "heading", "quote", "table", 
        "horizontal-rule", "preview", "fullscreen", "side-by-side"
        ,{
          name: "image",
          className: "fa fa-picture-o",
          title: "Insert image",
          action: function(editor) {
            console.log("insert image");
            Scribae.Editor.editor = editor;
            if(Scribae.Image.galleryModal) {
              Scribae.Image.galleryModal.open();
            }
          },
        },
        {
          name: "update",
          className: "fa fa-refresh",
          title: "Update",
          action: function(editor) {
            console.log("insert image");
            Scribae.Editor.editor = editor;
            Scribae.Markdown.decorateMarkdown('.editor-preview-active');
            Scribae.Markdown.decorateMarkdown('.editor-preview-active-side');
          },
        }
      ]
    });
    Scribae.Editor.simpleMDE.codemirror.on("preview", function(preview){
      console.log('preview has changed: '+preview);
      if(preview) {
        Scribae.Markdown.decorateMarkdown('.editor-preview-active');
      }
    });
    Scribae.Editor.simpleMDE.codemirror.on("sidebyside", function(preview){
      console.log('preview sidebyside has changed: '+preview);
      if(preview) {
        Scribae.Markdown.decorateMarkdown('.editor-preview-active-side');
        var elements = document.getElementsByClassName('editor-preview-side');
        if(elements.length == 1) {
          Scribae.Editor.observer.observe(elements[0], {
            childList: true,
            subtree: true,
            characterData: true
          });
        }

      } else {
        Scribae.Editor.observer.disconnect();
      }
    });
    Scribae.Editor.simpleMDE.codemirror.on("fullscreen", function(fullscreen){
      console.log('fullscreen has changed: '+fullscreen);
      if(fullscreen) {
        $('#app-navbar').hide();
        $('.fa-columns').show();
      } else {
        $('#app-navbar').show();
        $('.fa-columns').hide();
      }
    });
    $('.fa-columns').hide();
  }
}

