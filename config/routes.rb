Rails.application.routes.draw do
  devise_for :users
  resources :comments, only: [:edit, :create, :update, :destroy]

  get 'comments/_comments'
  get 'comments/_form'
  get 'login' => 'user/login', as: :login
  resources :blog_posts do
  	resources :comments
  end
  get 'about' => 'blog_posts#about'
  get 'contact' => 'blog_posts#contact'
  root 'blog_posts#index'

  get '/:name' => 'blog_posts#user_posts', as: :user_posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
