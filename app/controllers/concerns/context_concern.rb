module ContextConcern
  extend ActiveSupport::Concern

  included do
    before_action :inspect
  end
  private 
  def inspect 
    
    @controller_cxt = params[:controller]
    @action_cxt = params[:action]
    model_class = controller_name.classify
    if ["articles", "themes", "informations", "albums"].include?(@controller_cxt)
      @website = Website.find(params[:website_id])
    elsif not ["index", "create", "update"].include?(@action_cxt)
      @website = Website.find(params[:id])
    end

    @navigation = {
      :path=>[ { :label=>t('components.website.navbar'), :url=>websites_path } ],
      :tabs=>[],
      :dropdown=>false
    }
    #puts "#{@navigation.inspect}"
    case @controller_cxt
      when 'websites'
        unless @action_cxt == 'index' or @action_cxt == 'index'
          #@website = Website.find(params[:id])
          @navigation[:path].push( { :label=>@website.project, :url=>edit_website_path(@website) } )
          @navigation[:tabs].push( { :label=>t('components.article.navbar'), :url=>website_articles_path(@website) } )
          @navigation[:tabs].push( { :label=>t('components.theme.navbar'), :url=>website_themes_path(@website) } )
          @navigation[:tabs].push( { :label=>t('components.information.navbar'), :url=>website_informations_path(@website) } )
          @navigation[:tabs].push( { :label=>t('components.album.navbar'), :url=>website_albums_path(@website) } )
          #@navigation[:tabs].push( { :label=>t('components.map.navbar'), :url=>website_maps_path(@website) } )
        end
      else
        #@website = Website.find(params[:website_id]) 
        @navigation[:path].push( { :label=>@website.project, :url=>edit_website_path(@website) } )
    end

    #case controller_cxt
    #  when 'articles'
    #    @navigation[:path].push( {:label=>t 'components.article.navbar', :url=>articles_path(@website)} )
    #    unless @action_cxt == 'index'
    #      @article = Article.find(params[:id])
    #      @navigation[:path].push({:label=>@article.title, :url=>edit_article_path(@article))
    #    end
    #    @navigation[:tabs].push( {:label=>t 'components.theme.navbar', :url=>themes_path(@website)} )
    #    @navigation[:tabs].push( {:label=>t 'components.information.navbar', :url=>informations_path(@website)} )
    #    @navigation[:tabs].push( {:label=>t 'components.album.navbar', :url=>albums_path(@website)} )
    #    @navigation[:tabs].push( {:label=>t 'components.map.navbar', :url=>maps_path(@website)} )
    #    @navigation[:dropdown] = true
    #  
    #  when 'themes'
    #    @navigation[:path].push( {:label=>t 'components.theme.navbar', :url=>themes_path(@website)} )
    #    unless @action_cxt == 'index'
    #      @theme = Theme.find(params[:id])
    #      @navigation[:path].push({:label=>@theme.title, :url=>edit_theme_path(@article))
    #    end
    #    @navigation[:tabs].push( {:label=>t 'components.article.navbar', :url=>articles_path(@website)} )
    #    @navigation[:tabs].push( {:label=>t 'components.information.navbar', :url=>informations_path(@website)} )
    #    @navigation[:tabs].push( {:label=>t 'components.album.navbar', :url=>albums_path(@website)} )
    #    @navigation[:tabs].push( {:label=>t 'components.map.navbar', :url=>maps_path(@website)} )
    #    @navigation[:dropdown] = true
    #  when 'informations'
    #    
    #  
    #  when 'albums'
    #     
    #  when 'maps'
    #  
    #end

    #puts "Controller: #{ @controller_cxt }"
    #puts "Action: #{ @action_cxt }"
    
  end

end