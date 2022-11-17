Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :movies
  root :to => redirect('/movies')
  #get 'auth/:provider/callback', to: 'sessions#create'
  #get '/login', to: 'sessions#new'
  get  'auth/:provider/callback' => 'sessions#create'
  post 'logout' => 'sessions#destroy', :as => 'logout'
  get  'auth/failure' => 'sessions#failure'
  get  'auth/github', :as => 'login'
end
