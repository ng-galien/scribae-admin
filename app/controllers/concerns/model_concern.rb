module ModelConcern 
  extend ActiveSupport::Concern

  included do
    before_action :get_existing_model, only: [:destroy, :update, :edit]
    after_action :update_model, only: [:destroy, :update, :create, :edit]
    after_action :delete_model, only: []
  end

  def edit_model
    @image_list = @model_obj.images
    @image_main = @image_list[0]
    @image_new = Image.new do |img|
      img.category = 'content'
      img.imageable_type = "#{controller_name.classify}"
      img.imageable_id = params[:id]
    end
  end

  private

    def get_existing_model
      @model_obj = controller_name
      .classify
      .constantize
      .find(params[:id])
    end

    def update_model
      UpdateJob.perform_later @website, controller_name.classify
    end

end