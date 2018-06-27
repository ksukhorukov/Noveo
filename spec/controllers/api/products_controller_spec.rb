require 'rails_helper'

describe Api::ProductsController, type: :controller do
  describe '#index' do
    it '#index' do
      post :index
      expect(response.code).to eq('200')
    end
  end
end