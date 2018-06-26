# frozen_string_literal: true

class Api::CartsService
  attr_reader :params, :action
  attr_accessor :product, :errors

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

  def cart
    Rails.cache.fetch(:cart, expires_in: 5.minutes) do
      Api::Cart.create
    end
  end
end
