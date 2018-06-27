# frozen_string_literal: true

class Api::CartsController < ApplicationController
  before_action :init_service

  def index
    response, status = @service.show
    render json: response, status: status
  end

  def create
    response, status = @service.add
    render json: response, status: status
  end

  def destroy
    response, status = @service.delete
    render json: response, status: status
  end

  def cart_params
    params.permit(:product_id, :quantity)
  end

  private

  def init_service
    @service = Api::Carts::CartsService.new(cart_params, action_name)
  end
end
