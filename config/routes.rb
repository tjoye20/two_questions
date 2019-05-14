Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new'

  get '/sign-in', to: 'sessions#new', as: 'sign-in'
  get '/auth/google_oauth2/callback', to: 'users#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  resources :views, only: :create

  resources :sessions, only: [:new, :destroy]
  resources :profiles, only: [:index, :show] do 
    resources :questions, only: [:new, :create]
  end 
  
  resources :users, only: [:create] do 
    resources :profiles, only: [:new, :edit, :create, :update]
  end 

end
