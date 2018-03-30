class ThemesController < ApplicationController

  include PreviewConcern

  before_action :set_menu, only: [:index, :edit]

  #=================================================================================
  # Edit page
  # 
  # Params:
  def edit
    @website = Website.find(params[:website_id])
    @theme = Theme.find(params[:id])

    @image_list = @theme.images
    @image_main = @image_list[0]
    
    @image_new = Image.new do |img|
      img.category = 'content'
      img.imageable_type = 'Theme'
      img.imageable_id = params[:id]
    end
    @mardown = true;
  end

  #=================================================================================
  # Response to update
  # 
  # Params:
  def update
    @theme = Theme.find(params[:id])
    @theme.update(theme_params)
    website = Website.find(params[:website_id])
    update_preview website.preview
    redirect_to action: "index"
  end

  #=================================================================================
  # Response to create
  # 
  # Params:
  def create

    max = Theme.maximum("pos")
    if max.nil?
      max = 0
    end
    theme = Theme.new do |t|
      t.pos = max + 1   
    end
    theme.update(theme_params)
    image = Image.new do |img|
      img.category = 'main'
    end
    theme.images << image
    @website = Website.find(theme.website_id);
    @themes = Theme.where({website_id: theme.website_id})
      .order(pos: :desc); 
    respond_to do |format|
      format.js
    end
    #redirect_to action: "edit", id: @theme.id
  end

  #=================================================================================
  # Response to index
  # 
  # Params:
  def index
    @website = Website.find(params[:website_id])
    @themes = @website.themes.order(pos: :desc)
    @theme_new = Theme.new
  end

  #=================================================================================
  # Delete the thene
  # 
  # Params:
  def destroy
    theme = Theme.find(params[:id])
    @website = Website.find(theme.website_id);
    theme.destroy
    @themes = Theme.where({website_id: @website.id})
      .order(pos: :desc); 
    respond_to do |format|
      format.js
    end
  end

  private
    def theme_params
      params.require(:theme).
        permit(:website_id, :title, :intro, :markdown)
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
          :label => "Themes", :url=>website_themes_path(@website) } )
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
