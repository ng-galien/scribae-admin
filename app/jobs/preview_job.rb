require 'fileutils'
require 'yaml'

class PreviewJob < ApplicationJob
  queue_as :default

  include PreviewsHelper
  include TerminalHelper

  after_perform do |job|
    
    website = job.arguments.first
    preview = Preview.where(website_id: website.id).first
    terminal_log preview, terminal_info(I18n.t('preview.message.job.after'))
    if preview.is_stopped?
      jekyll_thread preview
    end
  end

  def perform(*args)
    # Get objects args
    
    website = args[0]
    config = args[1]
    preview = Preview.where(website_id: website.id).first
    terminal_log preview, terminal_info(I18n.t('preview.message.job.start'))
    # Stop the server if we must write config
    if config and preview.is_started?
      preview.stop
    end

    dest = get_dest_path preview
    # Copy static content and config
    if preview.is_stopped?
      terminal_log preview, terminal_info(I18n.t('preview.message.job.static'))
      copy_static_content preview.prototype, dest
      terminal_log preview, terminal_info(I18n.t('preview.message.job.config'))
      create_config website, dest
    end
    
    # Create/update all content
    # Components
    terminal_log preview, terminal_info(I18n.t('preview.message.job.components'))
    update_home = create_comps website, dest
    # Home
    terminal_log preview, terminal_info(I18n.t('preview.message.job.home'))
    create_home website, dest, update_home
    # Articles
    terminal_log preview, terminal_info(I18n.t('preview.message.job.articles'))
    create_articles website, dest
    # Themes
    terminal_log preview, terminal_info(I18n.t('preview.message.job.themes'))
    create_themes website, dest
    # Infos
    terminal_log preview, terminal_info(I18n.t('preview.message.job.infos'))
    create_infos website, dest
    # Albums
    terminal_log preview, terminal_info(I18n.t('preview.message.job.albums'))
    create_albums website, dest

  end  
end
