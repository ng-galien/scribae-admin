module ModelConcern 
  extend ActiveSupport::Concern

  #included do
  #  before_action :update_model, only: [:destroy, :create]
  #end

  def edit_model
    @model_obj = controller_name.
      classify
      .constantize
      .find(params[:id])
    @image_list = @model_obj.images
    @image_main = @image_list[0]
    @image_new = Image.new do |img|
      img.category = 'content'
      img.imageable_type = "#{controller_name.classify}"
      img.imageable_id = params[:id]
    end
  end

  private
    def set_model

    end
end