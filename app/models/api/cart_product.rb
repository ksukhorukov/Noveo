class Api::CartProduct < ApplicationRecord
	self.table_name = 'carts_products'

  belongs_to :product
  belongs_to :cart
end
