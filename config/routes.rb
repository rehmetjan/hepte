class AdminConstraint
  def self.matches?(request)
    if request.session[:user_id]
      user = User.find request.session[:user_id]
      user && user.admin?
    end
  end
end

Rails.application.routes.draw do
  
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
  
  concern :likeable do 
    resource :like, only: [:create, :destroy]
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
  
  resources :books, concerns: [:commentable, :likeable]
  
  scope path: '~:username', module: 'users', as: 'user' do
    resources :comments, only: [:index]
    root to: 'books#index'
  end
  
  namespace :admin do
    resources :categories, except: [:edit]
  end
  
  constraints(AdminConstraint) do
    mount Resque::Server.new, at: 'resque'
  end
  
end
