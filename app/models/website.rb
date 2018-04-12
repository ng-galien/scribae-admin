class Website < ApplicationRecord 
  
  include Stylable
  include Imageable

  validates :name, uniqueness: true

  has_one :gitconfig
  has_one :preview
  has_many :components
  has_many :articles
  has_many :themes
  has_many :infos
  has_many :albums

  accepts_nested_attributes_for :gitconfig
  accepts_nested_attributes_for :preview
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :components
  accepts_nested_attributes_for :themes
  accepts_nested_attributes_for :infos
  accepts_nested_attributes_for :albums
  accepts_nested_attributes_for :style
  

end
