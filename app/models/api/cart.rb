# frozen_string_literal: true

class Api::Cart < ApplicationRecord
  self.table_name = 'carts'

  has_many :carts_products, class_name: 'CartProduct'
  has_many :products, through: :carts_products

  def product_in_cart?(product)
    ::Api::CartProduct.find_by(cart_id: id, product: product.id)
  end
end
