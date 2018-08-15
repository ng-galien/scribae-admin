/**
 * Markdown Editor
 * It use simplemde as primary editor
 * add some function regarding image, videos and maps
 */

var Scribae = Scribae || {};

Scribae.Editor = Scribae.Editor || {
  TEXTFILED_CLASS: ".mde-editor",
  TOOLBAR_CLASS: ".editor-toolbar",
  SIDE_CLASS: ".editor-preview-side",
  PREVIEW_CLASS: ".editor-preview",
  init: function() {
    var editor = new Scribae.Editor.Markdown();
  }
};

Scribae.Editor.Markdown = function() {
  var textField = document.querySelector(Scribae.Editor.TEXTFILED_CLASS);
  if (textField) {
    this._mde = new SimpleMDE({
      element: textField,
      toolbar: [
        "bold", "italic", "strikethrough", "heading", "quote", "table", "horizontal-rule", "preview", "fullscreen", "side-by-side",
        {
          name: "image",
          className: "fa fa-picture-o",
          title: "Insert image",
          action: function(editor) {
            console.log("insert image");
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
            Scribae.Markdown.decorateMarkdown('.editor-preview-active');
            Scribae.Markdown.decorateMarkdown('.editor-preview-active-side');
          },
        }
      ]
    });
    this._preview = false;
    this._fullscreen = false;
    this._side = false;
    //Preview
    var cm = this._mde.codemirror;
    var wrapper = cm.getWrapperElement();
    var preview = document.querySelector(Scribae.Editor.PREVIEW_CLASS);
    if (!preview) {
      preview = document.createElement("div");
      preview.className = "editor-preview";
      wrapper.appendChild(preview);
    }

    this._previewObserver = new MutationObserver((records, observer) => {
      
      if(records.length > 0) {
        var className = records[0].target.className;
        this._preview = /editor-preview-active/.test(className);
        this.toggleDisplayMode();
      }
    });
    this._previewObserver.observe(preview, {attributes: true, attributeFilter: ["class"]});

    //Fullscreen
    this._fullscreenObserver = new MutationObserver((records, observer) => {
      
      if(records.length > 0) {
        var className = records[0].target.className;
        this._fullscreen = /CodeMirror-fullscreen/.test(className);
        this.toggleDisplayMode();
      }
      console.log(this);
    });
    this._fullscreenObserver.observe(wrapper, {attributes: true, attributeFilter: ["class"]});
    
    //Side
    this._sideObserver = new MutationObserver((records, observer) => {
      //console.log(records);
      if(records.length > 0) {
        var className = records[0].target.className;
        this._side = /editor-preview-active-side/.test(className);
        this.toggleDisplayMode();
      }
    });
    var side = document.querySelector(Scribae.Editor.SIDE_CLASS);
    this._sideObserver.observe(side, {attributes: true, attributeFilter: ["class"]});

    //Code
    cm.on("change", () => { if(this._side) this.updatePreview();});
  }
}
Scribae.Editor.Markdown.prototype.toggleDisplayMode = function() {
  if(this._fullscreen) {
    $('#app-navbar').hide();
    $('.fa-columns').show();
    $('#toc-menu').removeClass('toc-menu-navbar');
    $('#toc-menu').addClass('toc-menu-absolute');
  } else {
    $('#app-navbar').show();
    $('.fa-columns').hide();
    $('#toc-menu').addClass('toc-menu-navbar');
    $('#toc-menu').removeClass('toc-menu-absolute');
  }
  if(this._side || this._preview) {
    this.updatePreview();
  }
}
Scribae.Editor.Markdown.prototype.updatePreview = function() {
  console.log("must update preview");
}
