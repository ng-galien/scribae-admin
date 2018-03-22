class InfosController < ApplicationController

  before_action :set_menu, only: [:index, :edit]

  def new
    Theme.new
  end

  def edit
    @website = Website.find(params[:website_id])
    @info = Info.find(params[:id])
    @image_new = Image.new do |img|
      img.category = 'infor_content'
      img.imageable_type = 'Info'
      img.imageable_id = params[:id]
    end
    @image_list = Image.where({
      imageable_type: 'Info',
      imageable_id: params[:id]
    }).order(created_at: :desc); 
    @image_main = @image_list.last
  end

  def update
    @info = Info.find(params[:id])
    @info.update(info_params)
    redirect_to action: "index"
  end

  def create
    @info = Info.new
    @info.update(info_params)
    redirect_to action: "edit", id: @info.id
  end

  def destroy 
    @info = Info.find(params[:id])
    @info.destroy
    redirect_to action: "index"
  end

  def index
    #render plain: params.inspect
    @website = Website.find(params[:website_id])
    @infos = @website.infos
    @info_new = Info.new
    @info_new.index = Info.count + 10
  end

  private
    def info_params
      params.require(:info).
        permit(:website_id, :id, :index, :title, :markdown)
    end 

    def set_menu
      @navigation = {
        :path => [ { :label=>t('components.website.navbar'), :url=>websites_path } ],
        :links => [],
        :tabs => []        
      }
      action = params[:action]
      if not ["create", "update"].include?(action) 
        @website = Website.find(params[:website_id])
        #PATH
        @navigation[:path].push( { 
          :label => @website.project, :url=>edit_website_path(@website) } )
        @navigation[:path].push( { 
          :label => "Informations", :url=>website_infos_path(@website) } )
        #LINKS
        @navigation[:links].push( { 
          :label=>t('components.article.navbar'), :url=>website_articles_path(@website) } )
        @navigation[:links].push( { 
          :label=>t('components.theme.navbar'), :url=>website_themes_path(@website) } )
        @navigation[:links].push( { 
          :label=>t('components.information.navbar'), :url=>website_infos_path(@website) } )
        @navigation[:links].push( { 
          :label=>t('components.album.navbar'), :url=>website_albums_path(@website) } )
      end
    end

end
