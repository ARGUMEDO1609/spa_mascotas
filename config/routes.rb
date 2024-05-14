Rails.application.routes.draw do
  namespace :authentication, as: '', path: '' do
    resources :users, only: [:new, :create, :edit, :update], path: '/register', path_names: { new: '/' }
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: { new: '/' }
    resources :passwords, only: [:edit, :update], path:  'password', path_name: { edit: '/' }
  end
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#welcome"
end
