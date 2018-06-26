Rails.application.routes.draw do
  scope :api, module: :api, defaults: { format: :json } do
    resources :products, only: [:index]
    resources :cart, only: [:index, :create, :destroy]
  end
end
