class Album < ApplicationRecord
  include Imageable
  belongs_to :website
end
