#=================================================================================
# 
#=================================================================================
class Theme < ApplicationRecord
  include Imageable
  include Previewable
  belongs_to :website
  
end
