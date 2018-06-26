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
    return [format_errors, 400] unless valid_params?(:add)
  end

  def delete
    return [format_errors, 400] unless valid_params?(:delete)
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
