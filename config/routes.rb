Rails.application.routes.draw do
  
  devise_for :users
 root to: "homes#top"
 get 'mypage/:id', to: 'users#mypage', as: 'mypage'
 resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
 resources :users, only: [ :show, :edit, :update, :destroy]
 resources :books, only: [:index, :show]
 get "/homes/about" => "homes#about", as: "about"
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
