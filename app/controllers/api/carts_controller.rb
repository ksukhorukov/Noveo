# frozen_string_literal: true

class Api::CartsController < ApplicationController
  before_action :init_service

  def index
    result, status = @service.show
    render json: result, status: status
  end

  def create
    @service.add
    head :ok
  end

  def destroy
    @service.delete
    head :ok
  end

  def cart_params
    params.permit(:product_id, :quantity)
  end

  private

  def init_service
    @service = ::Api::CartsService.new(cart_params, action_name)
  end
end
