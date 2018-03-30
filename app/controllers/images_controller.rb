class ImagesController < ApplicationController

  #skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session
  
  #=================================================================================
  # Response to create
  # 
  # Params:
  def create
    @image = Image.new
    @image.update(update_params)
    @image.upload = params[:file]
    @image.save!
    #puts "type=#{@image.imageable_type}, id=#{@image.imageable_id}"
    set_gallery @image.imageable_type, @image.imageable_id
    @markdown = @image.imageable_type != 'Album';
    #puts "markdown=#{@markdown}"
    respond_to do |format|
      format.js
    end
    
  end

  #=================================================================================
  # Delete the image
  # 
  # Params:
  def destroy
    @image = Image.find(params[:id])
    imageable_id = @image.imageable_id
    imageable_type = @image.imageable_type
    @image.destroy
    #puts "type=#{imageable_type}, id=#{imageable_id}"
    set_gallery imageable_type, imageable_id
    @markdown = imageable_type != 'Album';
    #puts "markdown=#{@markdown}"
    respond_to do |format|
      format.js
    end
  end

  #=================================================================================
  # Response to update
  # 
  # Params:
  def update
    @image = Image.find(params[:id])
    @image.update(update_params)
    @image.upload = params[:file]
    @image.save!
    render json: @image
  end

  private

    def set_gallery imageable_type, imageable_id

      if imageable_type == 'Album' 
        @album = Album.find(imageable_id)
  
        @image_list = Image.where({
          imageable_type: imageable_type,
          imageable_id:   imageable_id,
          category: 'content',
        }).order(pos: :desc); 
        max = @image_list.maximum("pos")
        if max.nil?
          max = 0
        end
        @image_new = Image.new do |img|
          img.category = 'content'
          img.imageable_type = imageable_type
          img.imageable_id = imageable_id
          img.pos = max + 1
        end
      else
        @image_list = Image.where({
          imageable_type: imageable_type,
          imageable_id:   imageable_id,
        }).order(created_at: :desc); 
      end
    end

    def update_params
      params.require(:image)
        .permit(:name, :category, :imageable_type, :imageable_id, :pos, :file)
    end

end