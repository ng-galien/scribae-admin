class PreviewsController < ApplicationController

  include PreloaderConcern
  skip_before_action :verify_authenticity_token
  

  #========================================================
  #
  def status
    @preview = Preview.find(params[:preview_id])  
    server_status @preview
    respond_to do |format|
      format.js
    end
  end

  #========================================================
  #generate and start
  def start
    
    @preview = Preview.find(params[:preview_id])
    update_preview @preview
    head :ok
    #redirect_to action: 'status'
    
  end

  #========================================================
  #
  def stop
    @preview = Preview.find(params[:preview_id])
    StopJekyllJob.perform_later @preview
    redirect_to action: 'status'
  end

  #========================================================
  #
  def update_prototype
    @preview = Preview.find(params[:preview_id])
    PrototypeJob.perform_later @preview.website
    head :ok
  end

  def show
    @preview = Preview.find(params[:id])
    if @preview.is_started?
      @preloader_show = false
      @preloader_msg = t 'preview.ui.started'
    elsif @preview.is_starting?
      @preloader_show = true
      @preloader_msg = t 'preview.ui.starting'
    elsif @preview.is_stopped?
      @preloader_show = true
      @preloader_msg = t 'preview.ui.stopped'
    end
  end

  #========================================================
  #PRIVATE METHODS
  #========================================================
  private

end