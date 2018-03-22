class ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    @image = Image.new
    @image.update(update_params)
    @image.upload = params[:file]
    @image.save!
    @image_list = Image.where({
        imageable_type: update_params[:imageable_type],
        imageable_id: update_params[:imageable_id]
    }).order(created_at: :desc); 
    respond_to do |format|
      format.js
    end
  end

  def update
    @image = Image.find(params[:id])
    @image.update(update_params)
    @image.upload = params[:file]
    @image.save!
    
    render json: @image
  end
  private
    def update_params
      params.require(:image)
        .permit(:name, :category, :imageable_type, :imageable_id, :file)
    end

end