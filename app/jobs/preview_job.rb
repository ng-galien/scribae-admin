require 'fileutils'
require 'yaml'

#=================================================================================
# Job for creating the preview and start jekyll
#=================================================================================
class PreviewJob < ApplicationJob
  queue_as :default

  include PreviewsHelper
  include TerminalHelper

  after_perform do |job|
    
    website = job.arguments.first
    preview = Preview.where(website_id: website.id).first
    terminal_add preview, terminal_info(I18n.t('preview.message.job.after'))
    if preview.is_stopped?
      jekyll_thread preview
    end
  end

  def perform(*args)
    # Get objects args
    ActiveSupport::Dependencies.interlock.permit_concurrent_loads do
      website = args[0]
      all = args.length == 2 or args[1] or false
      preview = Preview.where(website_id: website.id).first
      preview.terminal_logs.destroy_all
      terminal_add preview, terminal_trigger(I18n.t('preview.trigger.clear'), "")
      terminal_add preview, terminal_info(I18n.t('preview.message.job.start'))
      # Stop the server if we must write config
      if all && preview.is_started?
        preview.stop
      end

      dest = get_dest_path preview
      # Copy static content and config
      if preview.is_stopped?
        terminal_add preview, terminal_info(I18n.t('preview.message.job.static'))
        copy_static_content website
        terminal_add preview, terminal_info(I18n.t('preview.message.job.config'))
        create_config website
      end
      
      # call create on each modules activated in Scribae
      if all
        modules = Rails.configuration.scribae['modules']
        modules.each do |module_name|
          update_domain website, module_name.singularize.capitalize
          #send("create_#{module_name}", website)
        end
      end
      update_domain website, "Component", true
      update_home website, true
      update_style website
    end
  end  
end
