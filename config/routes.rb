Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  root 'books#index'
 
  resources :users, only: [:create] do
    collection do
      get :check_email
      get :check_username
    end
  end
  
  concern :commentable do
    resources :comments, only: [:create]
  end
  
  resources :comments, only: [:edit, :update] do
    member do 
      get :cancel
      delete :trash
    end
  end
  
  namespace :settings do
    resource :password, only: [:show, :update]
    resource :account, only: [:show, :update]
    resource :profile, only: [:show, :update]
  end
  
  namespace :users do
    resource :password, only: [:show, :new, :create, :update, :edit]
    resource :confirmation, only: [:new, :show, :create]
  end
  
  resources :books, concerns: [:commentable]
  
  scope path: '~:username', module: 'users', as: 'user' do
    resources :comments, only: [:index]
    root to: 'comments#index'
  end
end
