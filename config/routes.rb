Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :campervans
  resources :bookings, only: [:new, :create, :index] do
    member do
      get :index_by_user
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
