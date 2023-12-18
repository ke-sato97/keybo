# frozen_string_literal: true

Rails.application.routes.draw do
  root 'top_page#top'
  get '/how_to_use', to: 'top_page#how_to_use'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  post '/guest_login', to: 'user_sessions#guest_login'
  get 'contacts/new'
  get 'contacts/confirm'
  get 'contacts/done'
  get 'keyboards/ranks'

  resources :keyboards do
    resources :comments
    collection do
      get :bookmarks
    end
  end
  resources :contacts, only: %i[new create] do
    collection do
      post :confirm
      post :back
      get :done
    end
  end
  resources :bookmarks, only: %i[index create destroy]
  resources :users, only: %i[new create destroy]
  resources :diagnoses, only: %i[index new show create]
  resources :password_resets, only: %i[new create edit update]
  resource :profile, only: %i[show edit update] do
    get :image_processing, on: :member
    patch :image_processing, on: :member
  end

  namespace :admin do
    root 'keyboards#search'
    get 'keyboards/search'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'

    resources :keyboards, only: %i[index show edit update destroy]
    resources :users
  end

  # 最後に書く
  get '*not_found', to: 'application#routing_error'
  post '*not_found', to: 'application#routing_error'
end
