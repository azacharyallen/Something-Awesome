Rails.application.routes.draw do
  root to: "sections#index"

  resources :users, only: [:show, :new, :create, :edit, :update] do
    resources :posts, only: [:index]
    resources :private_messages, only: [:new, :create]
  end

  resources :sections, only: [:show, :index]

  resources :forums, only: [:show] do
    resources :post_threads, only: [:new, :create]
  end

  resources :post_threads, except: [:new, :create] do
    resources :posts, only: [:new, :create]
  end

  resources :posts, only: [:show, :edit, :update, :destroy]

  resource :session, only: [:new, :create, :destroy]

  resources :bookmarks, only: [:index, :create, :destroy]

  resources :private_messages, only: [:show, :index, :destroy]

  get "/about", to: "static_pages#about"
end
