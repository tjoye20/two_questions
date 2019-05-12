Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new'

  get '/sign-in', to: 'sessions#new', as: 'sign-in'
  get '/auth/google_oauth2/callback', to: 'users#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/profiles/:uuid/questions/new', to: 'questions#new', as: :new_profile_questions
  post '/profiles/:uuid/questions', to: 'questions#create'
  delete '/profiles/:uuid/questions/:id', to: 'questions#destroy', as: :delete_profile_question
  resources :views, only: :create

  resources :sessions, only: [:new, :destroy]
  resources :profiles, only: [:index, :show] do 
    resources :questions, only: [:create, :destroy]
  end 
  
  resources :users, only: [:create] do 
    resources :profiles, only: [:new, :edit, :create, :update]
  end 

end
