require 'pp'
module MenuConcern 
  extend ActiveSupport::Concern
  
  included do
    before_action :init_menu, only: [:index, :edit]
  end


  private
  
  def init_menu
    
    @navigation = {
      :path => [ { :label=>t('components.website.navbar'), :url=>websites_path } ],
      :links => []      
    }
    pp params
    controller = params[:controller]
    action = params[:action]
    id = params[:id]
    website_id = params[:website_id]

    find_id = website_id ? website_id : id
    unless find_id.nil?
      puts "website id: #{find_id}"
      @website = Website.find find_id
      set_navigtion_links
    end
  end

  def set_navigtion_links
    
    #PATH
    @navigation[:path].push( { 
      :label=>@website.name, :url=>edit_website_path(@website) } )
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