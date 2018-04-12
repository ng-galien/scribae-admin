module Loggable
  
  extend ActiveSupport::Concern
  
  included do
    has_many :terminal_logs, as: :loggable, dependent: :destroy
  end

end