Rails.application.routes.draw do
  root to: "sections#index"

  resources :users

  resources :sections, only: [:show, :index]

  resources :forums, only: [:show] do
    resources :post_threads, only: [:new, :create]
  end

  resources :post_threads, except: [:new, :create] do
    resources :posts, only: [:new, :create]
  end

  resource :session, only: [:new, :create, :destroy]
end
