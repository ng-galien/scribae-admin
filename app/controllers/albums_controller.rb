class AlbumsController < ApplicationController
  
  include PreviewConcern
  include MenuConcern
  include ModelConcern
  
  #=================================================================================
  # Response to index
  # 
  # Params:
  def index
    @albums = @website.albums
      .order(pos: :desc)
    @album_new = Album.new
  end

  #=================================================================================
  # Edit page for Albums
  # 
  # Params:
  def edit
    edit_model
    max = @image_list.maximum("pos")
    if max.nil?
      max = 0
    end
    @image_new.pos = max+1
  end

  #=================================================================================
  # Response to Albums update
  # 
  # Params:
  def update
    @album = Album.find(params[:id])
    @album.update(album_params)
    website = Website.find(params[:website_id])
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
end