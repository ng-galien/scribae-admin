require 'fileutils'
require 'yaml'

class UpdateWebsiteJob < ApplicationJob
  queue_as :default

  include PreviewsHelper

  after_perform do |job|
    preview = job.arguments.first
    if !preview.running
      puts 'must start the server'
      #StartJekyllJob.perform_later preview
    else
      if !process_exists preview.pid
        puts "server has stopped"
        preview.pid = 0
        preview.running = false
        preview.save!
      end
    end
  end

  def perform(*args)
    # Copy everithing
    preview = args[0]
    model_class = args[1]
    host = args[2]
    dest = get_dest_path preview
    website = Website.find(preview.website_id)
    copy_static_content website.prototype, dest
    if !preview.running
      create_config website, dest
    end
    # Create/update all content
    
    update_home = create_comps website, dest
    create_home website, dest, update_home

    create_articles website, dest
    create_themes website, dest

    preview.updated = website.updated_at.to_f
    arr = host.split ':'
    arr[-1] = "#{4000}"; 
    preview.url = "http://#{arr.join ':'}"
    preview.save!
  end

  
end
