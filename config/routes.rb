Rails.application.routes.draw do
  namespace :authentication, as: '', path: '' do
    resources :users, only: [:new, :create], path: '/register', path_names: { new: '/' }
  end
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#welcome"
end
