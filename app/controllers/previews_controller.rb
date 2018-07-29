class PreviewsController < ApplicationController

  
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

  def show
    @preview = Preview.find(params[:id])
    @preloader_msg = "MESSAGE"
    @preloader_show = true
  end

  #========================================================
  #PRIVATE METHODS
  #========================================================
  private

end