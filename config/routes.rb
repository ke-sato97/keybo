Rails.application.routes.draw do
  root 'top_page#top'
  get '/how_to_use', to: 'top_page#how_to_use'

  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  post '/guest_login', to: 'user_sessions#guest_login'

  resources :keyboards do
    collection do
      get :bookmarks
    end
  end
  resources :bookmarks, only: %i[index create destroy]
  resources :users, only: %i[new create destroy]
  resources :diagnoses, only: %i[index new show create]
  resources :password_resets, only: %i[new create edit update]

  namespace :admin do
    root 'keyboards#search'
    get 'keyboards/search'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'

    resources :keyboards, only: %i[index show edit update destroy]
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
