module PreviewConcern
  extend ActiveSupport::Concern

  included do
    after_action :update_preview, only: [:update, :destroy]
  end

  private
    def update_preview
      unless @website.nil?
        config = false
        PreviewJob.perform_later @website, config
      end
    end
end