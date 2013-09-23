RailsAngularjsSse::Application.routes.draw do
  root 'shares#index'

  resources :shares, only: [:index]
end
