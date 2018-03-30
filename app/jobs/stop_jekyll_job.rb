
require 'fileutils'

class StopJekyllJob < ApplicationJob
  queue_as :default

  include PreviewsHelper

  def perform(*args)
    preview = args[0]
    if process_exists preview.pid
      kill_process preview.pid
    end
  end
end