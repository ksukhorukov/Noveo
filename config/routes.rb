Rails.application.routes.draw do
  scope :api, module: :api, defaults: { format: :json } do
    resources :products, only: [:index]
  end
end
