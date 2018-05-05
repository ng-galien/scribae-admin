class UpdateJob < ApplicationJob
  queue_as :default
  include PreviewsHelper

  after_perform do |job|
    
  end

  def perform(*args)
    begin
      args.length == 2 or !args[0].nil?  or !args[1].nil? or raise ArgumentError 'Argument is invalid'
      update_domain( args[0], args[1], true )
      #ActiveSupport::Dependencies.interlock.permit_concurrent_loads do
      #  update_content( args[0], args[1], true )
      #end
    rescue Exception => exception
      pp exception.message
      pp exception.backtrace
    end
    
  end
end