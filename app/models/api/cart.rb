class Api::Cart < ApplicationRecord
  self.table_name = 'carts'
  
  has_many :carts_products, class_name: 'CartProduct'
  has_many :products, through: :carts_products
end
