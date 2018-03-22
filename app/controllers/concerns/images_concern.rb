module ImagesConcern
  extend ActiveSupport::Concern
  
  included do
    def gallery
      @images = @obj.images
    end
  
    def upload
      get_parent
      @obj.images.create(image_params)
      respond_to do |format|
        format.json {render 'shared/gallery'}
      end
      
    end
  end
  

  
  
  private
    def image_params
      params.permit(:upload, :name, :intro)
    end

    def get_parent
      model_class = controller_name.classify
      id = "#{model_class.downcase}_id"
      oid = params[id]
      @obj = controller_name.classify.constantize.find(oid)
    end
end