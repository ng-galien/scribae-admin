class Gitconfig < ApplicationRecord
  include Loggable
  belongs_to :website

end
