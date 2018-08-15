#=================================================================================
# 
#=================================================================================
class Theme < ApplicationRecord
  include Imageable
  include Previewable

  belongs_to :website
  
  has_many :articles

end
