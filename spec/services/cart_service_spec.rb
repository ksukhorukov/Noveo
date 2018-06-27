require 'rails_helper'

RSpec.describe Api::Carts::CartsService do 

  context 'with valid params' do 
    it 'correctly adds product to cart' do 
      cart = FactoryBot.create(:cart)
      product = FactoryBot.create(:product)
      service = described_class.new({ 
        product_id: product.id.to_s,
        quantity: '5' 
      })
      allow(service).to receive(:current_cart).and_return(cart)
      expect(service.add).to match_array([nil, :ok])
    end

    it 'correctly deletes product from cart' do 
      cart = FactoryBot.create(:cart)
      product = FactoryBot.create(:product)
      service = described_class.new({ 
        product_id: product.id.to_s,
        quantity: '1'
      })
      allow(service).to receive(:current_cart).and_return(cart)
      service.add
      expect(service.delete).to match_array([nil, :ok])
    end

    it 'correctly displays the list of products' do 
      cart = FactoryBot.create(:cart)
      product = FactoryBot.create(:product)
      service = described_class.new({ 
        product_id: product.id.to_s,
        quantity: '1' 
      })
      allow(service).to receive(:current_cart).and_return(cart)
      service.add
      expect(service.show).to match_array([[product], :ok])      
    end
  end

  context 'with invalid params' do 
    it 'checks presence of product id when we add product to cart' do
      service = described_class.new({ quantity: '1'})
      result, status = service.add
      expect(status).to be_equal(400)
    end

    it 'checks presence of quantity when we add product to cart' do 
      service = described_class.new({ product_id: '1'})
      result, status = service.add
      expect(status).to be_equal(400)
    end

    it 'checks presence of product id when we delete product from cart' do 
      service = described_class.new({ quantity: '1', product_id: "#{rand(100)}"})
      result, status = service.delete
      expect(status).to be_equal(400)
    end

    it 'checks numericality of product id' do 
      service = described_class.new({ product_id: 'abc', quantity: '1'})
      result, status = service.add
      expect(status).to be_equal(400)
    end

    it 'checks numericality of quantity' do 
      service = described_class.new({ product_id: '1', quantity: 'abc'})
      result, status = service.add
      expect(status).to be_equal(400)
    end

    it 'checks that product with the given id exist when we add it to cart' do 
      service = described_class.new({ product_id: rand(100_000).to_s, quantity: '1'})
      result, status = service.add
      expect(status).to be_equal(400)
    end

    it 'cheack that the product with the given id exist when we delete product from cart' do 
      service = described_class.new({ product_id: rand(100_000).to_s})
      result, status = service.delete
      expect(status).to be_equal(400)
    end

    it 'no way to delete product that is not in cart' do 
      product = FactoryBot.create(:product)
      cart = FactoryBot.create(:cart)
      service = described_class.new({ product_id: product.id.to_s})
      allow(service).to receive(:current_cart).and_return(cart)
      result, status = service.delete
      expect(status).to be_equal(400)
    end
  end
end