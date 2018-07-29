class DeleteJob < ApplicationJob
  queue_as :default
  include PreviewHelper

  def perform(*args)
    begin
      args.length == 1 or !args[0].nil? or !args[1].nil? or raise ArgumentError 'Argument is invalid'
      website = args[0]
      domain = args[1]
      # call
      send("create_#{domain}", website)
    rescue Exception => exception
      pp exception.message
      pp exception.backtrace
    end
  end
end