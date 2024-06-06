Rails.application.routes.draw do
  namespace :authentication, as: '', path: '' do
    resources :users, only: [:new, :create, :edit, :update], path: '/register', path_names: { new: '/' }
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: { new: '/' }
    resources :passwords, only: [:edit, :update], path: '/password', path_names: { edit: '/' }
    get '/password_resets/edit', to: 'password_resets#edit', as: 'edit_password_reset'
    patch '/password_resets', to: 'password_resets#update'
    resources :password_resets, only: [:new, :create], path: '/password_resets', path_names: { new: '/' }

  end
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#welcome"
end
