# frozen_string_literal: true

class Api::CartsController < ApplicationController
  before_action :init_service

  def index
    render json: @service.show
  end

  def create
    result, status = @service.add
    render json: body, status: status
  end

  def destroy
    result, status = @service.delete
    render json: result, status: status
  end

  def cart_params
    params.permit(:product_id, :quantity)
  end

  private

  def init_service
    @service = ::Api::CartsService.new(cart_params, action_name)
  end
end
