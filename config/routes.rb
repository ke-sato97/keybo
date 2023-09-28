Rails.application.routes.draw do
  root 'top_page#top'

  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  post '/guest_login', to: 'user_sessions#guest_login'

  resources :users, only: %i[new create destroy]
  resources :keyboards
  resources :diagnoses, only: %i[index new show create]

  namespace :admin do
    root 'keyboards#search'
    get 'keyboards/search'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'

    resources :keyboards, only: %i[index show edit update destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
