Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts, only: [:index, :show, :create, :update, :destroy]
    end
  end

  resources :posts do
    resources :favourites, only: [:create, :destroy]
    resources :comments, only: [:new, :create, :destroy]
    resources :stars, shallow: true, only: [:create, :destroy, :update]
  end
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :users, only: [:new, :create, :edit, :update] do
    get :favourite_posts, on: :collection
  end
  resources :passwords, only: [:edit, :update]
  resources :tags, only: [:index, :show]

end
