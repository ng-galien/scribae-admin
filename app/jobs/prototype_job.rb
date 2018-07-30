class PrototypeJob < ApplicationJob
  queue_as :default
  
  include PreviewHelper

  after_perform do |job|
    
  end

  def perform(*args)
    begin
      args.length == 1 or !args[0].nil? or raise ArgumentError 'Argument is invalid'
      website = args[0]
      copy_static_content website, true
    rescue Exception => exception
      pp exception.message
      pp exception.backtrace
    end
    
  end
end