class Component < ApplicationRecord
  
  include Stylable
  belongs_to :website
  
end
