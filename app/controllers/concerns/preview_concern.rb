module PreviewConcern
  extend ActiveSupport::Concern

  include PreviewsHelper

  included do

    def update_preview preview
      model_class = controller_name.classify
      puts "update_preview from #{model_class}" 
      if preview.running or model_class == "Preview" or true
        host = request.host_with_port
        UpdateWebsiteJob.perform_later preview, model_class, host
      end
    end

    def server_status preview
      if preview.pid > 0
        if !process_exists preview.pid
          puts "server has stopped"
          preview.pid = 0
          preview.running = false
  
        else
          preview.running = true
        end
      else
        preview.running = false
      end
      preview.save
      #puts "preview status #{preview.inspect}"
    end
  end
  
end