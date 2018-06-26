class Api::Product < ApplicationRecord
  self.table_name = 'products'

  has_many :carts, through: :carts_products

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :price

  validates_numericality_of :price
end
