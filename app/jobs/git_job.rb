#=================================================================================
# Job for creating the preview and start jekyll
#=================================================================================
class GitJob < ApplicationJob

  queue_as :default
  
  include GitHelper
  include PreviewHelper

  after_perform do |job|

  end

  def perform(*args)

    config = args[0]
    unless config.initialized
      password = args[1]
      git_setup config, password
    else
      website = config.website
      create_config website, false
      git_commit config
    end
  end

end