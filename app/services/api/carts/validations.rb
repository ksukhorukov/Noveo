module Api::CartsService::Validations
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
    unless current_cart.product_in_cart?(current_product)
      product_error(
        code: 'required',
        message: 'Product not in cart'
        action: action
        )
      return true
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

  def params_error(params)
    errors << [params, :params_error]
  end

  def product_error(params)
    errors << [params, :product_error]
  end
end