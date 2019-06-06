Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount ActionCable.server => '/cable'
  
  root 'sessions#new'

  get '/sign-in', to: 'sessions#new', as: 'sign-in'
  get '/auth/google_oauth2/callback', to: 'users#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  resources :views, only: [:create, :update]

  resources :requests, only: [:index, :show] 
  resources :sessions, only: [:new, :destroy]

  resources :profiles, only: [:index, :show] do 
    resources :questions, only: [:new, :create]
    resources :requests, only: [:create, :update]
  end 
    
  resources :users, only: [:create] do 
    resources :profiles, only: [:new, :edit, :create, :update]
  end 

  resources :interests, only: :index
end
