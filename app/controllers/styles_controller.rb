class StylesController < ApplicationController

  #skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session

  #=================================================================================
  # Response to update
  # 
  # Params:
  def update
    style = Style.find(params[:id])
    style.update(update_params)
    save_style style.stylable_id
    head :ok
  end

  private

    def update_params
      params.require(:style)
        .permit(:helper, :navbar, :primary, :secondary, :background, 
          :icon, :text, :decoration)
    end

    def save_style website_id
      website = Website.find website_id
      SaveStyleJob.perform_later website
    end

end