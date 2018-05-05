require 'i18n'
#=================================================================================
class Website < ApplicationRecord 
  
  include Stylable
  include Imageable

  validates :name, uniqueness: true

  has_one :gitconfig, dependent: :destroy
  has_one :preview, dependent: :destroy
  
  has_many :components, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :themes, dependent: :destroy
  has_many :infos, dependent: :destroy
  has_many :albums, dependent: :destroy

  accepts_nested_attributes_for :gitconfig
  accepts_nested_attributes_for :preview
  accepts_nested_attributes_for :components

  #=================================================================================
  # Create website objects
  # Fill the website with default values
  # 
  # Params:
  def create_default
    # Default values
    self.site_title     = I18n.t 'websites.default.home_title'
    self.home_title     = I18n.t 'websites.default.home_title'
    self.home_icon      = I18n.t 'websites.default.home_icon'
    self.top_title      = I18n.t 'websites.default.top_title'
    self.top_intro      = I18n.t 'websites.default.top_intro'
    self.bottom_title   = I18n.t 'websites.default.bottom_title'
    self.bottom_intro   = I18n.t 'websites.default.bottom_intro'
    self.featured_title = I18n.t 'websites.default.featured_title'
    self.markdown       = I18n.t 'websites.default.markdown'
    self.show_featured  = true
    self.show_markdown  = true
    # Create components
    modules = Rails.configuration.scribae['modules']
    modules.each_with_index do |comp_name, index|
      component = Component.new do |comp| 
        comp.name        = comp_name
        comp.icon_color  = "#6268c0"
        comp.pos         = index + 1
        comp.show        = I18n.t "websites.default.components.#{comp_name}.show"
        comp.icon        = I18n.t "websites.default.components.#{comp_name}.icon"
        comp.title       = I18n.t "websites.default.components.#{comp_name}.title"
        comp.intro       = I18n.t "websites.default.components.#{comp_name}.intro"
      end
      self.components << component
    end
    # Create preview and gitconfig
    parameterized = self.name.parameterize
    self.preview = Preview.new do |preview|
      preview.prototype = "default"
      preview.name = parameterized
      preview.process = 0
      preview.status = 0
    end
    self.gitconfig = Gitconfig.new do |git|
      git.repo = parameterized
    end
    # Background images
    bg_file = File.open(Rails.root.join('app', 'assets', 'images', 'parallax.jpg'))
    ['top', 'bottom'].each do |name|
      image = Image.new do |img|
        img.name = name
        img.category = 'bg'
        img.upload = bg_file
      end 
      self.images << image
    end
    # Style
    self.style = Style.new do |style|
      style.helper = ""
      style.navbar = "#ffffff"
      style.primary = "#ffffff"
      style.secondary = "#000000"
      style.background = "#000000"
      style.icon = "#ffffff"
      style.text = "#000000"
      style.decoration = "#000000"
    end
  end

end
