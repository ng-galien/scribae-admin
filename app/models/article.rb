#=================================================================================
# 
#=================================================================================
class Article < ApplicationRecord
  
  include Imageable
  include Previewable

  belongs_to :website

  accepts_nested_attributes_for :images

end
