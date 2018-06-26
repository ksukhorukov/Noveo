# frozen_string_literal: true

class Api::Carts::CartsService
  attr_reader :params, :action
  attr_accessor :product, :errors

  include Validations

  def initialize(params = {}, action)
    @params = params
    @action = action
    @errors = []
  end

  def show
    [cart.products, 200]
  end

  def add
    return [response, 400] unless valid_params?(:add)
    current_cart.add_to_cart(current_product)
    [response, 200]
  end

  def delete
    return [response, 400] unless valid_params?(:delete)
    current_cart.delete_from_cart(current_product)
    [response, 200]
  end

  private

  def current_cart
    Rails.cache.fetch(:cart, expires_in: 5.minutes) do
      Api::Cart.create
    end
  end

  def current_product
    @product ||= Api::Product.find_by(id: params[:product_id])
  end
end
