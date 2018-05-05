class ThemesController < ApplicationController

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
    @model_obj.update(theme_params)
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
    @model_obj = Theme.new do |obj|
      obj.pos = max + 1   
    end
    @model_obj.update(theme_params)
    image = Image.new do |img|
      img.category = 'main'
    end
    @model_obj.images << image
    @website = Website.find(@model_obj.website_id);
    @themes = Theme.where({website_id: @model_obj.website_id})
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
    @website = Website.find(@model_obj.website_id);
    @model_obj.destroy
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
