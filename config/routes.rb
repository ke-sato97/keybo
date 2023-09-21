Rails.application.routes.draw do
  root 'top_page#top'

  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  get 'keyboards/search', to: 'keyboards#search'

  namespace :admin do
    get 'keyboards/search'
    get 'keyboards/edit'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
  end

  resources :users
  resources :keyboards
  resources :diagnoses, only: %i[index new show create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
