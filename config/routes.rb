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

  resources :previews, only: [], defaults: { format: 'js' }, shallow: true do
    get 'start', to: 'previews#start'
    get 'stop', to: 'previews#stop'
    get 'status', to: 'previews#status' 
  end

  resources :websites do
    
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
