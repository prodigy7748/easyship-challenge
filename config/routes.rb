Rails.application.routes.draw do
  resources  :companies, only: [] do
    resources :shipments, only: [:index, :show]
  end
end
