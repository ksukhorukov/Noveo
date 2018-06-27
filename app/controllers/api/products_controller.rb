class Api::ProductsController < ApplicationController
  def index
    render json: ::Api::Product.all, status: 200
  end
end
