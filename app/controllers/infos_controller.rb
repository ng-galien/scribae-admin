class InfosController < ApplicationController

  include PreviewConcern

  before_action :set_menu, only: [:index, :edit]

  #=================================================================================
  # Edit page
  # 
  # Params:
  def edit
    @website = Website.find(params[:website_id])
    @info = Info.find(params[:id])
    @image_list = @info.images

    @image_new = Image.new do |img|
      img.category = 'content'
      img.imageable_type = 'Info'
      img.imageable_id = params[:id]
    end
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
    update_preview website.preview
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
    #redirect_to action: "edit", id: @info.id
  end

  #=================================================================================
  # Response to index
  # 
  # Params:
  def index
    @website = Website.find(params[:website_id])
    @infos = @website.infos.order(pos: :desc)
    @info_new = Info.new
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
    #redirect_to action: "index"
  end

  private
    def info_params
      params.require(:info).
        permit(:website_id, :id, :pos, :title, :markdown)
    end 

    def set_menu
      @navigation = {
        :path => [ { :label=>t('components.website.navbar'), :url=>websites_path } ],
        :links => [],
        :tabs => []        
      }
      action = params[:action]
      if not ["create", "update"].include?(action) 
        @website = Website.find(params[:website_id])
        #PATH
        @navigation[:path].push( { 
          :label => @website.project, :url=>edit_website_path(@website) } )
        @navigation[:path].push( { 
          :label => "Informations", :url=>website_infos_path(@website) } )
        #LINKS
        @navigation[:links].push( { 
          :label=>t('components.article.navbar'), :url=>website_articles_path(@website) } )
        @navigation[:links].push( { 
          :label=>t('components.theme.navbar'), :url=>website_themes_path(@website) } )
        @navigation[:links].push( { 
          :label=>t('components.information.navbar'), :url=>website_infos_path(@website) } )
        @navigation[:links].push( { 
          :label=>t('components.album.navbar'), :url=>website_albums_path(@website) } )
      end
    end

end
