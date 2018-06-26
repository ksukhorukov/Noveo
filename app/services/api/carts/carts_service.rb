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
    return [format_errors, 400] if params_is_missing?(:product_id)
    return [format_errors, 400] if params_is_missing?(:quantity)
    return [format_errors, 400] if product_not_exist?
  end

  def delete
    return [format_errors, 400] if params_is_missing?(:product_id)
    return [format_errors, 400] if product_not_exist?
  end

  private

  def cart
    Rails.cache.fetch(:cart, expires_in: 5.minutes) do 
      Api::Cart.create
    end
  end

  def param_is_missing?(param_name)
    unless params[param_name].present?
      params_error(
          code: 'required'
          message: "#{param_name} cannot be blank.",
          name: param_name
        )
      return true
    end
  end

  def not_number?(param_name)
    unless params[param_name] =~ /^\d+$/
      params_error(
          code: 'required'
          message: 'Specify a number',
          name: param_name
        )
      return true
    end
  end

  def product_not_exist?
    unless current_product
      product_error(
        code: 'required',
        message: 'Product with this is does not exist'
        action: action
        )
      return true
    end
  end

  def product_not_in_cart?

    unless product
      product_error(
        code: 'required',
        message: 'Product not in cart'
        action: action
        )
      return true
    end
  end

  def current_product
    @product ||= Api::Product.find_by(id: params[:product_id])
  end

  def params_error(params)
    errors << [params, :params_error]
  end

  def product_error(params)
    errors << [params, :product_error]
  end
end