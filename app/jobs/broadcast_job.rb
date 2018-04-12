class BroadcastJob < ApplicationJob

  queue_as :default

  after_perform do |job|
    
  end

  def perform(*args)
    
    PreviewNotificationsChannel.broadcast_to(@post, @comment)
  end
  
end