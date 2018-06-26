require 'rails_helper'

RSpec.describe 'Api::Cart' do 
  it 'correctly adds product to cart' do 
    product = FactoryBot.create(:product)
    cart = FactoryBot.create(:cart)
    expect { cart.add_to_cart(product) }.to change { cart.products.count }.from(0)
  end

  it 'correctly identifies that product in cart' do 
    product = FactoryBot.create(:product)
    cart = FactoryBot.create(:cart)
    cart.add_to_cart(product)
    expect(cart.product_in_cart?(product)).to be_equal(true)
  end

  it 'correctly deletes product from cart' do 
    product = FactoryBot.create(:product)
    cart = FactoryBot.create(:cart)
    cart.add_to_cart(product)
    expect { cart.delete_from_cart(product) }.to change { cart.products.count }.from(1)
  end
end