# frozen_string_literal: true

class Api::Cart < ApplicationRecord
  self.table_name = 'carts'

  has_many :carts_products, class_name: 'CartProduct'
  has_many :products, through: :carts_products

  def product_in_cart?(product)
    ::Api::CartProduct.find_by(cart_id: id, product_id: product.id) ? true : false
  end

  def delete_from_cart(product)
    ::Api::CartProduct.find_by(cart_id: id, product_id: product.id).delete
  end

  def add_to_cart(product)
    ::Api::CartProduct.create(cart_id: id, product_id: product.id)
  end
end
