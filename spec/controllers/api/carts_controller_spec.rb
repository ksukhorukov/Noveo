require 'rails_helper'

describe Api::CartsController, type: :controller do
  context 'with invalid params' do 
    it 'returns 400 status when product cannot be added' do
      post :create, params: { product_id: rand(100_000) }
      expect(response.code).to eq('400')
    end

    it 'returns 400 when product cannot be deleted' do
      delete :destroy, params: { product_id: rand(100_000) }
      expect(response.code).to eq('400')
    end
  end

  context 'with valid params' do 
    it 'successfully adds product to the cart' do 
      product = FactoryBot.create(:product)
      post :create, params: { product_id: product.id, quantity: 1 }
      expect(response.code).to eq('200')
    end

    it 'successfully deletes product from cart' do 
      product = FactoryBot.create(:product)
      cart = FactoryBot.create(:cart)
      cart.add_to_cart(product)
      allow_any_instance_of(Api::Carts::CartsService).to receive(:current_cart).and_return(cart)
      delete :destroy, params: { product_id: product.id }
      expect(response.code).to eq('200')
    end
  end
end