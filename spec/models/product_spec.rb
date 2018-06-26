# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Product do
  it 'is not valid with blank name' do
    product = Api::Product.new(description: 'test product', price: 123)
    expect(product).not_to be_valid
  end

  it 'is not valid with blank description' do
    product = Api::Product.new(name: 'test name', price: 123)
    expect(product).not_to be_valid
  end

  it 'is not valid with blank price' do
    product = Api::Product.new(name: 'test name', description: 'test description')
    expect(product).not_to be_valid
  end

  it 'is not valid when price is not a number' do
    product = Api::Product.new(name: 'test name', description: 'test description', price: 'not valid price')
    expect(product).not_to be_valid
  end

  it 'is valid with correct fields' do
    product = Api::Product.new(name: 'test name', description: 'test description', price: 123)
    expect(product).to be_valid
  end
end
