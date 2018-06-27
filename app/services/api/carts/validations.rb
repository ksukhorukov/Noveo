# frozen_string_literal: true

module Api::Carts::Validations
  private

  def valid_params?(action)
    send("valid_params_#{action}?")
  end

  def valid_params_add?
    return false if param_is_missing?(:product_id)
    return false if not_number?(:product_id)
    return false if param_is_missing?(:quantity)
    return false if not_number?(:quantity)
    return false if product_not_exist?
    true
  end

  def valid_params_delete?
    return false if param_is_missing?(:product_id)
    return false if not_number?(:product_id)
    return false if product_not_exist?
    true
  end

  def not_number?(param_name)
    unless /^\d+$/.match?(params[param_name])
      params_error(
        code: 'required',
        message: 'Specify a number',
        name: param_name
      )
    end
  end

  def product_not_exist?
    unless current_product
      params_error(
        code: 'required',
        message: 'Product with this id does not exist',
        action: action
      )
    end
  end

  def product_not_in_cart?
    unless current_cart.product_in_cart?(current_product)
      params_error(
        code: 'required',
        message: 'Product not in cart',
        action: action
      )
    end
  end

  def param_is_missing?(param_name)
    unless params[param_name].present?
      params_error(
        code: 'required',
        message: "#{param_name} cannot be blank.",
        name: param_name
      )
    end
  end

  def params_error(params)
    @errors << params
  end

  def form_error
    return unless @errors.any?

    result = { params: [] }
    @errors.each { |e| result[:params] << e }

    {
      error: result,
      type: 'invalid_param_error',
      message: 'Invalid data parameters'
    }
  end
end
