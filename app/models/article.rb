class Article < ApplicationRecord
  
  include Imageable

  belongs_to :website

  accepts_nested_attributes_for :images

end
