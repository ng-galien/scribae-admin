class Gitconfig < ApplicationRecord
  include Loggable
  belongs_to :website

  def is_initialized? 
    !!self.initialized
  end

end
