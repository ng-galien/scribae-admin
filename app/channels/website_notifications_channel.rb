class WebsiteNotificationsChannel < ApplicationCable::Channel
  def subscribed

    stream_from "#{params[:loggable_type]}:#{params[:loggable_id]}"
    #stream_from "web_notifications_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
