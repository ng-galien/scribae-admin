require 'open3'
require 'i18n'

module JekyllHelper

  include TerminalHelper
  include PreviewHelper

  CMD_WARNING_REGEX = /warning/
  BUNDLE_CHECK_REGEX = /The Gemfile's dependencies are satisfied/
  JEKYLL_START_REGEX = /Server running... press ctrl-c to stop./
  JEKYLL_UPDATE_REGEX = /...done in ([0-9]*[.][0-9]*) seconds./
  JEKYLL_URL_REGEX = /Server address: (.*)/

  #=================================================================================
  # Create the thead process for the Jekyll server
  # 
  # Params:
  # +preview+:: the preview
  def jekyll_thread preview
    terminal_add preview, terminal_info(I18n.t('preview.message.start'))
    Rails.application.executor.wrap do
      Thread.new do
        Rails.application.reloader.wrap do
          Rails.application.executor.wrap do
            start_jekyll preview
          end
        end
      end
    end
  end

  #=================================================================================
  # Start the Jekyll server for a preview
  # 
  # Params:
  # +preview+:: the preview
  def start_jekyll preview
    path = get_dest_path preview
    Dir.chdir path
    Bundler.with_clean_env do
      ActiveSupport::Dependencies.interlock.permit_concurrent_loads do
        begin
          continue = true
          # Test if bundle was previously updated
          out, status = Open3.capture2e("bundle check")
          continue = status.success?
          #unless continue
          #  raise "Bundle check failed"
          #end
          bundle_updated = BUNDLE_CHECK_REGEX =~ out
          # Update the bundle
          if bundle_updated.nil?
            Open3.popen2e("bundle update jekyll") do |i, oe, t|
              terminal_add preview, terminal_info(I18n.t('preview.message.bundle.start'))
              oe.each {|line|
                #puts line
                terminal_add preview, terminal_cmd(line)
                #error = /warning/ =~ line
              }
              continue = t.value.success?
              if continue
                terminal_add preview, terminal_info(I18n.t('preview.message.bundle.end'))
              else
                terminal_add preview, terminal_info(I18n.t('preview.message.bundle.error'))
              end
            end
            unless continue
              return
            end
          end
          # Start Jekyll server 
          Open3.popen2e("bundle exec jekyll serve --config _config_local.yml") do |i, oe, t|
            terminal_add preview, terminal_trigger(I18n.t('preview.trigger.start'), '')
            terminal_add preview, terminal_info(I18n.t('preview.message.jekyll.start'))
            preview.set_starting t.pid
            oe.each {|line|
              #puts line
              #error = /warning/ =~ line
              terminal_add preview, terminal_cmd(line)
              if JEKYLL_URL_REGEX =~ line
                address = line.scan JEKYLL_URL_REGEX
                preview.url = address[0][0]
                preview.save
              elsif JEKYLL_START_REGEX=~ line
                preview.set_started
                # Trigger started
                terminal_add preview, terminal_trigger(I18n.t('preview.trigger.run'), '')
                terminal_add preview, terminal_info(I18n.t('preview.message.jekyll.started'))
              elsif JEKYLL_UPDATE_REGEX =~ line
                duration = line.scan JEKYLL_UPDATE_REGEX
                # Trigger updated
                terminal_add preview, terminal_trigger(I18n.t('preview.trigger.update'), "#{duration[0][0]}")
              end
            }
          rescue Exception => exception
            pp exception.backtrace
            terminal_add preview, terminal_trigger(I18n.t('preview.trigger.error'), exception.backtrace)
            terminal_add preview, terminal_info(I18n.t('preview.message.jekyll.error'))  
          end
        end
        preview.stop
        # Trigger stopped
        terminal_add preview, terminal_trigger(I18n.t('preview.trigger.stop'), '')
        terminal_add preview, terminal_info(I18n.t('preview.message.jekyll.end'))
      end
    end
  end
end