Rails.application.routes.draw do

  get '/vendor/account',  to: 'vendor#new',  as: :vendor
  post '/vendor/account',  to: 'vendor#create',  as: :vendor_create

  namespace :admin do

      get '/',  to: 'login#index',  as: :login
      post '/', to: 'login#account', as: :login_post
      
      get '/dashboard', to: 'dashboard#index', as: :home
      get '/logout', to: 'dashboard#logout', as: :logout

      resources :password_resets, only: [:new, :create, :edit, :update]
      resources :category, only: [:new, :index, :create, :edit, :update, :destroy]

      get '/vendors', to: 'page#vendors', as: :vendors
      get '/users', to: 'page#users', as: :users

      get '/vendors/:id', to: 'page#vendorproducts', as: :vendor_products

  end

  namespace :vendor do

      get '/',  to: 'login#index',  as: :login
      post '/', to: 'login#account', as: :login_post
      
      get '/dashboard', to: 'dashboard#index', as: :home
      get '/logout', to: 'dashboard#logout', as: :logout

      resources :product, only: [:new, :index, :create, :edit, :update, :destroy]

      #resources :password_resets, only: [:new, :create, :edit, :update]

  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # administrator

  
end
