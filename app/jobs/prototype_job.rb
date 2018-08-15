class PrototypeJob < ApplicationJob
  queue_as :default
  
  include PreviewHelper

  after_perform do |job|
    
  end

  def perform(*args)
    begin
      args.length == 1 or !args[0].nil? or raise ArgumentError 'Argument is invalid'
      website = args[0]
      update_prototype website
    rescue Exception => exception
      pp exception.message
      pp exception.backtrace
    end
    
  end
end