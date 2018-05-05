class InfosController < ApplicationController

  include MenuConcern
  include ModelConcern

  #=================================================================================
  # Response to index
  # 
  # Params:
  def index
    @infos = @website.infos
      .order(pos: :desc)
    @info_new = Info.new
  end

  #=================================================================================
  # Edit page
  # 
  # Params:
  def edit
    edit_model
    @mardown = true;
  end

  #=================================================================================
  # Response to Infos update
  # 
  # Params:
  def update
    @info = Info.find(params[:id])
    @info.update(info_params)
    website = Website.find(params[:website_id])
    #update_preview website.preview
    redirect_to action: "index"
  end

  #=================================================================================
  # Response to  Infos create
  # 
  # Params:
  def create

    max = Info.maximum("pos")
    if max.nil?
      max = 0
    end
    info = Info.new do |i|
      i.pos = max + 1   
    end
    
    info.update(info_params)

    image = Image.new do |img|
      img.category = 'main'
    end
    info.images << image

    @website = Website.find(info.website_id);
    @infos = Info.where({website_id: info.website_id})
      .order(pos: :desc); 
    respond_to do |format|
      format.js
    end
  end

  #=================================================================================
  # Delete the Info
  # 
  # Params:
  def destroy 
    info = Info.find(params[:id])
    @website = Website.find(info.website_id);
    info.destroy
    @infos = Info.where({website_id: @website.id})
      .order(pos: :desc); 
    respond_to do |format|
      format.js
    end
  end

  private
    def info_params
      params.require(:info).
        permit(:website_id, :id, :pos, :title, :markdown)
    end 
end
