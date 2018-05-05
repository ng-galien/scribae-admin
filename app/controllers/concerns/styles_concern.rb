module StylesConcern
  extend ActiveSupport::Concern
  
  included do
    #before_action :get_existing_model, only: [:update]
    #after_action :save_style, only: [:update]
  end
  private

end