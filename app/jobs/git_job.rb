
class GitJob < ApplicationJob

  queue_as :default
  
  include GitHelper

  after_perform do |job|

  end

  def perform(*args)
    config = args[0]
    unless config.initialized
      password = args[1]
      git_cmd_setup config, password
    else
      git_cmd_commit config
    end
  end

end