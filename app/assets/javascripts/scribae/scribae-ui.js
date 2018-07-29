/**
 * UI Components
 */
var Scribae = Scribae || {};

Scribae.UI = Scribae.UI || {
}

//============ PRELOADER COMPONENT ============//


/**
 * Constructor, pass jquery selector
 * @param {string} id 
 */
Scribae.UI.Preloader = function(id) {
  console.log(id);
  this._spinner = $(id).find('.preloader-wrapper').first();
  this._message = $(id).find('.preloader-message').first();
  console.log(this._spinner);
  console.log(this._message);
}

/**
 * Set the message of the preloader, if arg is null hide the message
 * @param {string} message 
 */
Scribae.UI.Preloader.prototype.setMessage = function(message) {
  if (Scribae.null(message)) {
    this._message.addClass('hide');
  } else {
    this._message.removeClass('hide');
    this._message.find('span').html(message);
  }
}
/**
 * 
 * @param {*} message 
 */
Scribae.UI.Preloader.prototype.show = function(message) {
  this.setMessage(message);
  this._spinner.removeClass('hide');
}
/**
 * 
 * @param {*} message 
 */
Scribae.UI.Preloader.prototype.hide = function(message) {
  this.setMessage(message);
  this._spinner.addClass('hide');
}
