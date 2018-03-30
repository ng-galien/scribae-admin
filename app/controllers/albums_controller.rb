class AlbumsController < ApplicationController
  
  include PreviewConcern

  before_action :set_menu, only: [:index, :edit]
  
  #=================================================================================
  # Edit page for Albums
  # 
  # Params:
  def edit
    @website = Website.find(params[:website_id])
    @album = Album.find(params[:id])

    @image_list = @album.images.where(category: 'content').order(pos: :desc)
    @image_main = @album.images.where(category: 'main').first

    max = @image_list.maximum("pos")
    if max.nil?
      max = 0
    end

    @image_new = Image.new do |img|
      img.category = 'content'
      img.imageable_type = 'Album'
      img.imageable_id = params[:id]
      img.pos = max + 1
    end
    @mardown = false;
  end

  #=================================================================================
  # Response to Albums update
  # 
  # Params:
  def update
    @album = Album.find(params[:id])
    @album.update(album_params)
    website = Website.find(params[:website_id])
    update_preview website.preview
    redirect_to action: "index"
  end

  #=================================================================================
  # Response to Albums create
  # 
  # Params:
  def create

    max = Album.maximum("pos")
    if max.nil?
      max = 0
    end
    album = Album.new do |a|
      a.pos = max + 1   
    end
    album.update(album_params)
    
    image = Image.new do |img|
      img.category = 'main'
      img.pos = 0
    end
    album.images << image

    @website = Website.find(album.website_id);
    @albums = Album.where({website_id: album.website_id})
      .order(pos: :desc); 
    respond_to do |format|
      format.js
    end
    #redirect_to action: "edit", id: @album.id
  end

  #=================================================================================
  # Response to index
  # 
  # Params:
  def index
    @website = Website.find(params[:website_id])
    @albums = @website.albums.order(pos: :desc)
    @album_new = Album.new
  end

  #=================================================================================
  # Delete the Album
  # 
  # Params:
  def destroy
    album = Album.find(params[:id])
    @website = Website.find(album.website_id);
    album.destroy

    @albums = Album.where({website_id: @website.id})
      .order(pos: :desc); 
    respond_to do |format|
      format.js
    end
    #redirect_to action: "index"
  end

  #=================================================================================
  # Get the form for the pos field
  # 
  # Params:
  def form
    @album = Album.find(params[:form_id])
    respond_to do |format|
      format.js
    end
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