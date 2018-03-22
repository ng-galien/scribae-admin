class Map < ApplicationRecord
  include Imageable
  belongs_to :website
end
