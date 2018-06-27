class ErrorsController < ApplicationController
  def not_found
    render json: error('invalid_request_error'), status: 404
  end

  def internal_server_error
    render json: error('internal_server_error'), status: 500
  end

  private

  def error(type)
    {
      'error': {
        'type': type,
        'message': "Unable to resolve the request"
      } 
    }
  end
end