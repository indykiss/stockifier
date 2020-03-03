Rails.application.routes.draw do
  resources :portfolios
  resources :stocks
  resources :users

  root 'sessions#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'

  delete '/signout', to: 'sessions#destroy'

  post '/sessions/create', to: 'sessions#create'

  get '/stocks', to: 'stocks#index'

  get '/search', to: 'stocks#search'


  get '/portfolio', to: 'portfolio#index'

  # Maybe need to build a scaffold for transactions?





  # Note to self:
  # I am going through the rails guide and datapond and copying and pasting what makes
  # sense as I forgot how this works

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
