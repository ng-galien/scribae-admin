require 'fileutils'

class WebsitesController < ApplicationController
  
  include MenuConcern
  include PreviewConcern


  #=================================================================================
  def init
    redirect_to action: "index"
  end

  #=================================================================================
  # Response to index
  # 
  # Params:
  def index   
    @websites = Website.all
      .order(created_at: :desc)
    @website_neraiw = Website.new
    StopPreviewJob.perform_later
  end

  #=================================================================================
  # GET /websites/new
  def new
    @website = Website.new
  end
  
  #=================================================================================
  # Edit page
  # 
  # Params:
  def edit

    @icons = Rails.configuration.icons['material']
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
    @gitconfig = @website.gitconfig
    PreviewJob.perform_later @website, false
  end

  #=================================================================================
  # Response to update
  # 
  # Params:
  def update
    @website = Website.find(params[:id])
    @website.update(update_params)
    @components = @website.components.order(id: :asc)
    respond_to do |format|
      format.js
    end
  end

  #=================================================================================
  # Response to create
  # 
  # Params:
  def create
    @website = Website.new(create_params)
    sample @website
    @website.save!
    #Preview
    parameterized = @website.name.parameterize
    @website.preview = Preview.new do |preview|
      preview.prototype = "default"
      preview.name = parameterized
      preview.status = 0
      preview.pid = 0
    end
    @website.gitconfig = Gitconfig.new do |git|
      git.repo = parameterized
    end
    #@website.save!
    #articles
    articles = Article.where({website_id: @website.id})
    articles.each do |article|
      image = Image.new do |img|
        img.category = 'article_main'
      end
      article.images << image
      #article.save!
    end
    
    #FileUtils.cp(
    #  Rails.root.join('app', 'assets', 'images', 'parallax.jpg'),
    #  Rails.root.join('app', 'assets', 'images', "parallax-1.jpg"))
    bg_file = File.open(Rails.root.join('app', 'assets', 'images', 'parallax.jpg'))
    #background top image
    ['top', 'bottom'].each do |name|
      image = Image.new do |img|
        img.name = name
        img.category = 'bg'
        img.upload = bg_file
      end 
      @website.images << image
    end

    #image.save!
    ##background top image
    ##FileUtils.cp(
    ##  Rails.root.join('app', 'assets', 'images', 'parallax.jpg'),
    ##  Rails.root.join('app', 'assets', 'images', "parallax-2.jpg"))
    #image = Image.new do |img|
    #  img.name = 'bottom'
    #  img.category = 'bg'
    #end 
    #@website.images << image
    #File.open(Rails.root.join('app', 'assets', 'images', 'parallax-1.jpg')) do |f|
    #  image.upload = f
    #end
    #image.save!
    @websites = Website.all
      .order(created_at: :desc)
    respond_to do |format|
      format.js
    end
  end

  #=================================================================================
  # Delete the website
  # 
  # Params:
  def destroy
    @website = Website.find(params[:id])
    @website.destroy
    @websites = Website.all
      .order(created_at: :desc)
    respond_to do |format|
      format.js
    end
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

      website.site_title     = t 'websites.default.home_title'
      website.home_title     = t 'websites.default.home_title'
      website.home_icon      = t 'websites.default.home_icon'
      website.top_title      = t 'websites.default.top_title'
      website.top_intro      = t 'websites.default.top_intro'
      website.bottom_title   = t 'websites.default.bottom_title'
      website.bottom_intro   = t 'websites.default.bottom_intro'
      website.featured_title = t 'websites.default.featured_title'
      website.markdown       = t 'websites.default.markdown'
      website.show_featured  = true
      website.show_markdown  = true
      #components
      modules = Rails.configuration.scribae['modules']
      modules.each_with_index do |comp_name, index|
        component = Component.new do |comp| 
          comp.name        = comp_name
          comp.icon_color  = "#6268c0"
          comp.pos         = index + 1
          comp.show        = t "websites.default.components.#{comp_name}.show"
          comp.icon        = t "websites.default.components.#{comp_name}.icon"
          comp.title       = t "websites.default.components.#{comp_name}.title"
          comp.intro       = t "websites.default.components.#{comp_name}.intro"
        end
        website.components << component
      end
      #fake articles
      2.times do |i|
        art = website.articles.new do |a|
          a.fake = true
          a.date = DateTime.now
          a.title = "#{t 'websites.default.article.fake.title'} #{i}"
          a.intro = "#{t 'websites.default.article.fake.intro'} #{i}"
        end
        website.articles << art
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #=================================================================================
    def create_params
      params.require(:website).permit(:name, :description)
    end

    #=================================================================================
    def update_params
      params.require(:website).permit(
        :prototype, :description, :readme,
        :title, 
        :top_title, :top_intro, 
        :bottom_title, :bottom_intro, 
        :featured_title, :show_featured, 
        :show_markdown, :markdown,
        components_attributes: [:id, :show, :pos, :icon, :icon_color, :title, :intro]
      )
    end
end
