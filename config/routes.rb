Rails.application.routes.draw do
  root 'api/products#index'

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'

  scope :api, module: :api, defaults: { format: :json } do
    resources :products, only: [:index]
    get 'cart', to: 'carts#index'
    post 'cart', to: 'carts#create'
    delete 'cart/:product_id', to: 'carts#destroy'
  end
end
