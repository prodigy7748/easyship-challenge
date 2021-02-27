Rails.application.routes.draw do
  resources :companies do
    resources :shipments, only: [:index, :show]
  end
end
