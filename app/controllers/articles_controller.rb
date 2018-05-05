class ArticlesController < ApplicationController
  
  include MenuConcern
  include ModelConcern

  #=================================================================================
  # Response to Article index
  # 
  # Params:
  def index
    @articles = @website.articles
      .where(fake: false)
      .order(created_at: :desc); 
    @article_new = Article.new
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
    @model_obj.update(article_params)
    @website = Website.find(params[:website_id])
    #update_preview website.preview
    redirect_to action: "index"
  end

  #=================================================================================
  # Response to create
  # 
  # Params:

  def create
    @model_obj = Article.new do |obj|
      obj.fake = false
      obj.featured = false
      obj.date = DateTime.now
    end
    @model_obj.update(article_params)  
    image = Image.new do |img|
      img.category = 'main'
    end
    @model_obj.images << image
    @website = Website.find(@model_obj.website_id);
    @articles = Article
      .where(website_id: @model_obj.website_id, fake: false)
      .order(created_at: :desc); 
    respond_to do |format|
      format.js
    end
  end

  #=================================================================================
  # Delete the article
  # 
  # Params:  
  def destroy
    @website = Website.find(@model_obj.website_id);
    @model_obj.destroy
    @articles = Article
      .where(website_id: @model_obj.website_id, fake: false)
      .order(created_at: :desc); 
    respond_to do |format|
      format.js
    end
  end

  private

    def article_params
      params.require(:article).
        permit(:website_id, :fake, :date, :featured, :title, :intro, :markdown)
    end 

end
