module PreloaderConcern 
  extend ActiveSupport::Concern
  included do
    before_action :init_preview
  end
  private
  def init_preview
    @preloader_msg = nil
    @preloader_show = false
  end
end