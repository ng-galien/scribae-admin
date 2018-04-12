class TerminalLog < ApplicationRecord
  
  belongs_to :loggable, polymorphic: true

  after_create_commit :broadcast
  
  private
  
  #broadcast to ActionCable channel
  def broadcast
    ActionCable.server.broadcast "#{self.loggable_type}:#{self.loggable_id}", self
  end
end
