#=================================================================================
# 
#=================================================================================
class Article < ApplicationRecord
  
  include Imageable
  include Previewable

  belongs_to :website
  belongs_to :theme, optional: true
  accepts_nested_attributes_for :images

end
