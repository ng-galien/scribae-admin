class TerminalController < ApplicationController
  def index
    @website = Website.find params[:website_id]
    @preview = @website.preview
    @gitconfig = @website.gitconfig
  end
end
