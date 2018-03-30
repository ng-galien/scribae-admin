class ArticlesController < ApplicationController
  
  include PreviewConcern

  before_action :set_menu, only: [:index, :edit]

  #=================================================================================
  # Edit page
  # 
  # Params:
  def edit
    @website = Website.find(params[:website_id])
    @article = Article.find(params[:id])

    @image_list = @article.images
    @image_main = @image_list[0]
    
    @image_new = Image.new do |img|
      img.category = 'content'
      img.imageable_type = 'Article'
      img.imageable_id = params[:id]
    end
    @mardown = true;
  end

  #=================================================================================
  # Response to update
  # 
  # Params:
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    website = Website.find(params[:website_id])
    update_preview website.preview
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
    #redirect_to action: "edit", id: @article.id
  end

  #=================================================================================
  # Response to Article index
  # 
  # Params:
  def index
    @website = Website.find(params[:website_id])
    @articles = @website.articles
      .where(fake: false)
      .order(created_at: :desc); 
    @article_new = Article.new
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

    def set_menu
      @navigation = {
        :path => [ { :label=>t('components.website.navbar'), :url=>websites_path } ],
        :links => [],
        :tabs => []        
      }
      action = params[:action]
      if not ["create", "update"].include?(action) 
        @website = Website.find(params[:website_id])
        #PATH
        @navigation[:path].push( { 
          :label => @website.project, :url=>edit_website_path(@website) } )
        @navigation[:path].push( { 
          :label => "Articles", :url=>website_articles_path(@website) } )
        #LINKS
        @navigation[:links].push( { 
          :label=>t('components.article.navbar'), :url=>website_articles_path(@website) } )
        @navigation[:links].push( { 
          :label=>t('components.theme.navbar'), :url=>website_themes_path(@website) } )
        @navigation[:links].push( { 
          :label=>t('components.information.navbar'), :url=>website_infos_path(@website) } )
        @navigation[:links].push( { 
          :label=>t('components.album.navbar'), :url=>website_albums_path(@website) } )
        #TABS

        #puts "articles_controller action > #{action}"
        #if(action == 'edit')
        #  @navigation[:tabs].push( { 
        #    :label=>t('article.tabs.properties.title'), :id=>"#article_tab_properties" } )
        #  @navigation[:tabs].push( { 
        #    :label=>t('article.tabs.content.title'), :id=>"#article_tab_content" } )
        #end
      end
    end
end
