class SaveStyleJob < ApplicationJob
  queue_as :default
  include PreviewsHelper

  after_perform do |job|
    
  end

  def perform(*args)
    begin
      args.length == 1 or !args[0].nil? or raise ArgumentError 'Argument is invalid'
      update_style args[0]
    rescue Exception => exception
      pp exception.message
      pp exception.backtrace
    end
    
  end
end