class ArticlesController < ApplicationController
  
  include PreviewConcern
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
    @article = Article.find(params[:id])
    @article.update(article_params)
    @website = Website.find(params[:website_id])
    #update_preview website.preview
    redirect_to action: "index"
  end

  #=================================================================================
  # Response to Article create
  # 
  # Params:

  def create
    article = Article.new do |art|
      art.fake = false
      art.featured = false
    end
    article.date = DateTime.now
    article.update(article_params)  
    image = Image.new do |img|
      img.category = 'main'
    end
    article.images << image
    @website = Website.find(article.website_id);
    @articles = Article
      .where(website_id: article.website_id, fake: false)
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
    article = Article.find(params[:id])
    @website = Website.find(article.website_id);
    article.destroy
    @articles = Article
      .where(website_id: article.website_id, fake: false)
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
