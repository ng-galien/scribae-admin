class Info < ApplicationRecord
  include Imageable
  belongs_to :website
end
