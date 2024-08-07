# config/routes.rb
Rails.application.routes.draw do
  get 'orders/new'
  get 'orders/create'
  get 'orders/index'
  get 'orders/show'
  get 'carts/show'
  get 'carts/add_item'
  get 'carts/remove_item'
  get 'products/index'
  get 'products/show'
  get 'home/index'

    get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :products, only: [:index, :show]
  resource :cart, only: :show do
    post 'add_item', to: 'carts#add_item'
    delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'
    patch 'update_item/:id', to: 'carts#update_item', as: 'update_item'
  end

  resources :orders, only: [:new, :create, :index, :show] do
    collection do
      get 'recalculate_totals'
    end
  end
  resources :addresses, only: [:new, :create, :edit, :update, :destroy]

  resources :users do
    resources :addresses, only: [:new, :create, :edit, :update, :destroy]
  end
end
