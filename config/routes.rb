Rails.application.routes.draw do
  scope :api, module: :api, defaults: { format: :json } do
    resources :products, only: [:index]
    get 'cart', to: 'carts#index'
    post 'cart', to: 'carts#create'
    delete 'cart/:product_id', to: 'carts#destroy'
  end
end
