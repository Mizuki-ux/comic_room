Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    get 'dashboards/:id', to: 'dashboards#show', as: 'dashboard'
    get "search" => "searches#search"
    resources :users, only: [:show, :destroy]
   resources :products, only: %i[index show new create edit update]
   resources :posts, only: %i[show update]
  end

  scope module: :public do
  devise_for :users
 root to: "homes#top"
  get 'mypage/:id', to: 'users#mypage', as: 'mypage'
  get "/homes/about" => "homes#about", as: "about"
  get "search" => "searches#search"
 resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
  resources :post_comments, only: [:create, :destroy]
 end
 resources :users, only: [ :show, :edit, :update, :destroy]
 resources :books, only: [:index, :show]
 resources :products, only: %i[index show]
 end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
