# frozen_string_literal: true

class Api::Cart < ApplicationRecord
  self.table_name = 'carts'

  has_many :carts_products, class_name: 'CartProduct'
  has_many :products, through: :carts_products

  def product_in_cart?(product)
    ::Api::CartProduct.find_by(cart_id: id, product_id: product.id) ? true : false
  end

  def delete_from_cart(product)
    product_in_cart = Api::CartProduct.find_by(cart_id: id, product_id: product.id)
    if product_in_cart
      current_quantity = product_in_cart.quantity
      if current_quantity == 1
        product_in_cart.destroy 
      else
        product_in_cart.quantity -= 1
        product_in_cart.save
      end
      return :ok
    else
      return :error
    end
  end

  def add_to_cart(product, quantity = 1)
    quantity = quantity.to_i
    product_in_cart = Api::CartProduct.find_by(cart_id: id, product_id: product.id)
    if product_in_cart.present?
      product.quantity += quantity
      product.save
    else
      ::Api::CartProduct.create(cart_id: id, product_id: product.id, quantity: quantity)
    end
  end

  def total_sum
    joined_products.map { |p| p.quantity * p.product.price }.reduce(:+)
  end

  def joined_products
    @joined_products ||= cart_products.includes(:product)
  end

  def products_quantity
    @products_quantity ||= cart_products.sum(:quantity)
  end

  def cart_products
    @cart_products ||= Api::CartProduct.where(cart_id: id)
  end
end
