
require 'fileutils'

class StopPreviewJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Preview.all.each do |preview| 
      preview.stop
    end
  end

end