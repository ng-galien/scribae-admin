class ThemesController < ApplicationController

  before_action :set_menu, only: [:index, :edit]

  def new
    Theme.new
  end

  def edit
    @website = Website.find(params[:website_id])
    @theme = Theme.find(params[:id])
    @image_new = Image.new do |img|
      img.category = 'theme_content'
      img.imageable_type = 'Theme'
      img.imageable_id = params[:id]
    end
    @image_list = Image.where({
      imageable_type: 'Theme',
      imageable_id: params[:id]
    }).order(created_at: :desc); 
    @image_main = @image_list.last
  end

  def update
    @theme = Theme.find(params[:id])
    @theme.update(theme_params)
    redirect_to action: "index"
  end

  def create
    @theme = Theme.new
    @theme.update(theme_params)
    image = Image.new do |img|
      img.category = 'theme_main'
    end
    @theme.images << image
    redirect_to action: "edit", id: @theme.id
  end


  def index
    #render plain: params.inspect
    @website = Website.find(params[:website_id])
    @themes = @website.themes
    @theme_new = Theme.new
  end

  private
    def theme_params
      params.require(:theme).
        permit(:website_id, :fake, :date, :featured, :title, :intro, :markdown)
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
        #TABS
      end
    end

end
