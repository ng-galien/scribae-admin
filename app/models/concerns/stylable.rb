#=================================================================================
# 
#=================================================================================
module Stylable

  extend ActiveSupport::Concern
  
  included do
    has_one :style, as: :stylable, dependent: :destroy
    accepts_nested_attributes_for :style
  end

end