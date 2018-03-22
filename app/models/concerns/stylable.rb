module Stylable

  extend ActiveSupport::Concern
  
  included do
    has_one :style, as: :stylable
  end

end