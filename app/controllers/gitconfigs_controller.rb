require 'pp'
class GitconfigsController < ApplicationController

  skip_before_action :verify_authenticity_token

  #========================================================
  #
  def setup
    #pp git_params
    config = Gitconfig.find(git_params[:gitconfig_id])  
    config.user = git_params[:user]
    config.email = git_params[:email]
    password = git_params[:password]
    config.save!
    GitJob.perform_later config, password
    head :ok
  end

  def commit
    #pp git_params
    config = Gitconfig.find(git_params[:gitconfig_id])  
    GitJob.perform_later config, nil
    head :ok
  end

  def git_params
    params.permit(:gitconfig_id, :user, :email, :password)
  end

end