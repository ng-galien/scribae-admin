require 'fileutils'

class StartJekyllJob < ApplicationJob
  queue_as :default

  include PreviewsHelper

  after_perform do |job|
    sleep 5
    preview = job.arguments.first
    preview.running = process_exists preview.pid
    puts "preview running #{preview.running }"
    preview.save!
  end

  def perform(*args)
    preview = args[0]
    path = Rails.root.join("preview", "#{preview.id}")
    Bundler.with_clean_env do
      Dir.chdir path do
        #preview.port = 4000 + preview.id 
        #website.url = "http://localhost:#{preview.port}"
        pid = spawn("bundle update")
        Process.wait pid
        preview.pid = spawn( "bundle exec jekyll serve --livereload --reload_port 4001", [:out, :err]=>["jekyll.log", "w"])
        Process.detach preview.pid
      end  
    end
  end


end