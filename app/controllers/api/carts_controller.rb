# frozen_string_literal: true

class Api::CartsController < ApplicationController
  def index
    response, status = service.show
    unless response
      head :ok
    else
      render json: response, status: status
    end
  end

  def create
    response, status = service.add
    unless response
      head :ok
    else
      render json: response, status: status
    end
  end

  def destroy
    response, status = service.delete
    unless response
      head :ok
    else
      render json: response, status: status
    end
  end

  def cart_params
    params.permit(:product_id, :quantity)
  end

  private

  def service
    @service ||= Api::Carts::CartsService.new(cart_params, action_name)
  end
end
