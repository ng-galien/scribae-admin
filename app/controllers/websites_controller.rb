require 'fileutils'

class WebsitesController < ApplicationController
  
  include PreviewConcern
  #before_action :set_website, only: [:show, :update, :destroy]
  before_action :set_menu, only: [:index, :edit]


  #=================================================================================
  def init
    redirect_to action: "index"
  end

  #=================================================================================
  # GET /websites
  # GET /websites.json
  def index
    #render plain: params.inspect    
    @websites = Website.all
    @website_new = Website.new
  end

  #=================================================================================
  # GET /websites/new
  def new
    @website = Website.new
  end
  
  #=================================================================================
  # GET /websites/edit
  def edit

    @icons = Rails.configuration.icons['material']
    @website = Website.find(params[:id])
    @image_list = Image.where({
      imageable_type: 'Website',
      imageable_id: params[:id],
    }).order(created_at: :desc); 
    @components = @website.components
      .order(id: :asc)
    @articles = @website.articles
      .where(fake: true)
      .select(:title, :intro, :date)
    @image_top = Image.where({
      imageable_type: 'Website',
      imageable_id: params[:id],
      name: 'top'
    }).order(updated_at: :desc)[0]; 
    @image_bottom = Image.where({
      imageable_type: 'Website',
      imageable_id: params[:id],
      name: 'bottom'
    }).order(updated_at: :desc)[0]; 
    @preview = @website.preview
    update_preview @preview
  end

  #=================================================================================
  def update
    #upd = update_params
    @website = Website.find(params[:id])
    @website.update(update_params)
    @components = @website.components.order(id: :asc)
    preview = @website.preview
    update_preview preview
    respond_to do |format|
      format.js
    end
  end

  #=================================================================================
  # POST /websites
  # POST /websites.json
  def create
    @website = Website.new(create_params)
    sample @website
    #@website.save!
    #Preview
    @website.preview = Preview.new do |p|
      p.pid = 0
      p.updated = 0
      p.running = false
      p.created = false
    end
    @website.save!
    #articles
    articles = Article.where({website_id: @website.id})
    articles.each do |article|
      image = Image.new do |img|
        img.category = 'article_main'
      end
      article.images << image
      #article.save!
    end
    #background top image
    FileUtils.cp(
      Rails.root.join('app', 'assets', 'images', 'parallax.jpg'),
      Rails.root.join('app', 'assets', 'images', "parallax-1.jpg"))
    image = Image.new do |img|
      img.name = 'top'
      img.category = 'bg'
    end 
    @website.images << image
    File.open(Rails.root.join('app', 'assets', 'images', 'parallax-1.jpg')) do |f|
      image.upload = f
    end
    image.save!
    #background top image
    FileUtils.cp(
      Rails.root.join('app', 'assets', 'images', 'parallax.jpg'),
      Rails.root.join('app', 'assets', 'images', "parallax-2.jpg"))
    image = Image.new do |img|
      img.name = 'bottom'
      img.category = 'bg'
    end 
    @website.images << image
    File.open(Rails.root.join('app', 'assets', 'images', 'parallax-1.jpg')) do |f|
      image.upload = f
    end
    image.save!
    redirect_to(edit_website_path(@website))
  end

  #=================================================================================
  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website = Website.find(params[:id])
    @website.destroy
    redirect_to action: "index"
  end

  #=================================================================================
  def build
    GenerateWebsiteJob.perform_later params[:website_id]
    redirect_to action: "index"
  end

  #=================================================================================
  def run
    JekyllJob.perform_later params[:website_id]
    redirect_to action: "index"
  end

  private

    #=================================================================================
    def sample website

      website.prototype      = 'default'
      website.site_title     = t 'website.default.home_title'
      website.home_title     = t 'website.default.home_title'
      website.home_icon      = t 'website.default.home_icon'
      website.top_title      = t 'website.default.top_title'
      website.top_intro      = t 'website.default.top_intro'
      website.bottom_title   = t 'website.default.bottom_title'
      website.bottom_intro   = t 'website.default.bottom_intro'
      website.featured_title = t 'website.default.featured_title'
      website.markdown       = t 'website.default.markdown'
      website.show_featured  = true
      website.show_markdown  = true
      #components
      modules = Rails.configuration.scribae['modules']
      modules.each_with_index do |comp_name, index|
        component = Component.new do |comp| 
          comp.name        = comp_name
          comp.icon_color  = "#6268c0"
          comp.pos         = index + 1
          comp.show        = t "website.default.components.#{comp_name}.show"
          comp.icon        = t "website.default.components.#{comp_name}.icon"
          comp.title       = t "website.default.components.#{comp_name}.title"
          comp.intro       = t "website.default.components.#{comp_name}.intro"
        end
        website.components << component
      end
      #fake articles
      2.times do |i|
        art = website.articles.new do |a|
          a.fake = true
          a.date = DateTime.now
          a.title = "#{t 'website.default.article.fake.title'} #{i}"
          a.intro = "#{t 'website.default.article.fake.intro'} #{i}"
        end
        website.articles << art
      end
      
    end

    def set_menu
      @navigation = {
        :path => [ { :label=>t('components.website.navbar'), :url=>websites_path } ],
        :links => [],
        :tabs => []        
      }
      action = params[:action]
      if not ["index", "create", "update"].include?(action) 
        @website = Website.find(params[:id])
        #PATH
        @navigation[:path].push( { 
          :label=>@website.project, :url=>edit_website_path(@website) } )
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
       
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #=================================================================================
    def create_params
      params.require(:website).permit(:project, :description)
    end

    #=================================================================================
    def update_params
      params.require(:website).permit(
        :prototype, :project, :description, :url, :repo, :token, :readme,
        :title, 
        :top_title, :top_intro, 
        :bottom_title, :bottom_intro, 
        :featured_title, :show_featured, 
        :show_markdown, :markdown,
        components_attributes: [:id, :show, :pos, :icon, :icon_color, :title, :intro]
        )
    end

end
