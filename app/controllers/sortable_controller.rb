class SortableController < ApplicationController

  #=================================================================================
  # Themes sorting
  # 
  # Params:
  def themes
    @website = Website.find(params[:website_id])
    @website.update(themes_params)
    @themes = @website.themes.order(pos: :desc)
    respond_to do |format|
      format.js
    end
  end

  #=================================================================================
  # Infos sorting
  # 
  # Params:
  def infos
    @website = Website.find(params[:website_id])
    @website.update(infos_params)
    @infos = @website.infos.order(pos: :desc)
    respond_to do |format|
      format.js
    end
  end

  #=================================================================================
  # Albums sorting
  # 
  # Params:
  def albums
    @website = Website.find(params[:website_id])
    @website.update(albums_params)
    @albums = @website.albums.order(pos: :desc)
    respond_to do |format|
      format.js
    end
  end

  #=================================================================================
  # Image sorting for an album
  # 
  # Params:
  def images
    @album = Album.find(params[:album_id])
    @album.update(images_params)
    @image_list = @album.images.where(category: 'content').order(pos: :desc)
    respond_to do |format|
      format.js
    end
  end

  private
  def themes_params
    params.require(:website).permit(
      themes_attributes: [:id, :pos]
    )
  end

  def infos_params
    params.require(:website).permit(
      infos_attributes: [:id, :pos]
    )
  end

  def albums_params
    params.require(:website).permit(
      albums_attributes: [:id, :pos]
    )
  end

  def images_params
    params.require(:album).permit(
      images_attributes: [:id, :pos]
    )
  end

end