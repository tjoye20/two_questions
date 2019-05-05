Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new'

  get '/sign-in', to: 'sessions#new', as: 'sign-in'
  get '/auth/google_oauth2/callback', to: 'users#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions, only: [:new, :destroy]
  resources :profiles, only: [:index]
  resources :users, only: [:create] do 
    resources :profiles, except: [:index, :destroy]
  end 

end
