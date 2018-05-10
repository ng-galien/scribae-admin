Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #get 'profile', to: 'users#show'
  #concern :imageable do
  #  resources :images, only: [:index, :update, :destroy], defaults: { format: 'js' }    
  #end
  
  #resources :images, :defaults => { :format => :json }
  # Routes for sortable controller
  patch 'sortable/:website_id/themes', to: 'sortable#themes', defaults: { format: 'js' }  
  patch 'sortable/:website_id/infos', to: 'sortable#infos', defaults: { format: 'js' } 
  patch 'sortable/:website_id/albums', to: 'sortable#albums', defaults: { format: 'js' } 
  patch 'sortable/:album_id/images', to: 'sortable#images', defaults: { format: 'js' } 

  # Routes for image controller
  resources :images, defaults: { format: 'js' }  

   # Routes for style controller
   resources :styles, defaults: { format: 'js' }  

  # Routes for github controller
  resources :gitconfigs, only: [], defaults: { format: 'js' }, shallow: true do
    post 'setup', to: 'gitconfigs#setup'
    get 'commit', to: 'gitconfigs#commit'
  end

  resources :websites do

      # Routes for preview controller
    resources :previews, only: [:show], shallow: true do
      get 'start', to: 'previews#start', defaults: { format: 'js' }
      get 'stop', to: 'previews#stop', defaults: { format: 'js' }
    end
    
    resources :terminal, only: [:index]
    resources :configs

    resources :articles
    #resources :articles, :except => [:create, :destroy]#, concerns: :imageable
    #resources :articles, :only => [:create, :destroy], :defaults => { :format => 'js' }
    resources :themes#, concerns: :imageable

    resources :infos#, concerns: :imageable
    
    resources :albums do#, concerns: :imageable
      get 'form', to: 'albums#form', defaults: { format: 'js' } 
    end
      
  end
  root 'websites#init'
end
