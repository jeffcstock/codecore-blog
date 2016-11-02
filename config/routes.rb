Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :posts do
    resources :favourites, only: [:create, :destroy]
    resources :comments, except: [:index]
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
