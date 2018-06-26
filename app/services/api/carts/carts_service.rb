# frozen_string_literal: true

class Api::Carts::CartsService
  include Validations

  attr_reader :params
  attr_accessor :product, :errors, :action

  def initialize(params = {}, action = nil)
    @params = params
    @errors = []
    @action = action
  end

  def show
    response(body: current_cart.products)
  end

  def add
    return response(status: :error) unless valid_params?(:add)
    current_cart.add_to_cart(current_product)
    response
  end

  def delete
    return response(status: :error) unless valid_params?(:delete)
    current_cart.delete_from_cart(current_product)
    response
  end

  private

  def response(body: nil, status: :ok)
    return [form_error, 400] if status == :error
    [body, :ok]
  end

  def current_cart
    Rails.cache.fetch(:cart, expires_in: 5.minutes) do
      Api::Cart.create
    end
  end

  def current_product
    @product ||= Api::Product.find_by(id: params[:product_id])
  end
end
