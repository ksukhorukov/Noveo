class Api::ProductsController < ApplicationController
  def index
    render json: Product.all, status: 200
  end
end
