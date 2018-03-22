class Website < ApplicationRecord 
  
  include Stylable
  include Imageable

  has_many :components
  has_many :articles
  has_many :themes
  has_many :infos
  has_many :albums

  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :components
  accepts_nested_attributes_for :style
  #def website_components_attributes=(attributes)
  #end
end
