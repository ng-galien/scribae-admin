class AlbumsController < ApplicationController
  
  before_action :set_menu, only: [:index, :edit]
  
  def new 
    Album.new
  end

  def create
    @album = Album.new
    @album.update(album_params)
    image = Image.new do |img|
      img.category = 'album_main'
    end
    @album.images << image
    redirect_to action: "edit", id: @album.id
  end

  def edit
    @website = Website.find(params[:website_id])
    @album = Album.find(params[:id])
    @image_list = @album.images
    @image_main = @image_list[0]
    @image_new = Image.new do |img|
      img.category = 'article_content'
      img.imageable_type = 'Album'
      img.imageable_id = params[:id]
    end
  end

  def update
    @album = Album.find(params[:id])
    @album.update(album_params)
    redirect_to action: "index"
  end

  def index
    @website = Website.find(params[:website_id])
    @albums = @website.albums
    @album_new = Album.new
    if Album.count == 0
      @album_new.index = 10
    else
      @album_new.index = Album.maximum("index") +  10
    end
    @album_new.extern = false
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to action: "index"
  end

  private
    def album_params
      params.require(:album).
        permit(:website_id, :index, :title, :intro, :extern, :link)
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
          :label => "Albums", :url=>website_albums_path(@website) } )
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