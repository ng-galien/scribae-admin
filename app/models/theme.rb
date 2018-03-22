class Theme < ApplicationRecord
  include Imageable
  belongs_to :website
end
