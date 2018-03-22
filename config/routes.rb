Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #get 'profile', to: 'users#show'
  #concern :imageable do
  #  resources :images, only: [:index, :update, :destroy], defaults: { format: 'js' }    
  #end
  
  #resources :images, :defaults => { :format => :json }
  resources :images, defaults: { format: 'js' }  

  resources :websites do
    
    get 'build', to: 'websites#build'
    get 'run', to: 'websites#run'

    resources :articles#, concerns: :imageable
    
    resources :themes#, concerns: :imageable
    
    resources :infos#, concerns: :imageable
    
    resources :albums#, concerns: :imageable
      
  end
  root 'websites#init'
end
