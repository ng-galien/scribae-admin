class ThemesController < ApplicationController

  include PreviewConcern
  include MenuConcern
  include ModelConcern

  #=================================================================================
  # Response to index
  # 
  # Params:
  def index
    @themes = @website.themes
      .order(pos: :desc)
    @theme_new = Theme.new
  end

  #=================================================================================
  # Edit page
  # 
  # Params:
  def edit
    edit_model
    @mardown = true;
  end

  #=================================================================================
  # Response to update
  # 
  # Params:
  def update
    @theme = Theme.find(params[:id])
    @theme.update(theme_params)
    website = Website.find(params[:website_id])
    #update_preview website.preview
    redirect_to action: "index"
  end

  #=================================================================================
  # Response to create
  # 
  # Params:
  def create

    max = Theme.maximum("pos")
    if max.nil?
      max = 0
    end
    theme = Theme.new do |t|
      t.pos = max + 1   
    end
    theme.update(theme_params)
    image = Image.new do |img|
      img.category = 'main'
    end
    theme.images << image
    @website = Website.find(theme.website_id);
    @themes = Theme.where({website_id: theme.website_id})
      .order(pos: :desc); 
    respond_to do |format|
      format.js
    end
  end

  #=================================================================================
  # Delete the thene
  # 
  # Params:
  def destroy
    theme = Theme.find(params[:id])
    @website = Website.find(theme.website_id);
    theme.destroy
    @themes = Theme.where({website_id: @website.id})
      .order(pos: :desc)
    respond_to do |format|
      format.js
    end
  end

  private
    def theme_params
      params.require(:theme).
        permit(:website_id, :title, :intro, :markdown)
    end 
end
