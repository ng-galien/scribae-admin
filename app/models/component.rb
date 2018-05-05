class Component < ApplicationRecord
  
  include Stylable
  include Previewable
  
  belongs_to :website
  
end
