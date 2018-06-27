class Api::CartSerializer < ActiveModel::Serializer
  attributes :data

  def data
    {
      total_sum: object.total_sum,
      products_count: object.products_quantity,
      products: products_in_cart
    }
  end

  def products_in_cart
    object.joined_products.map do |product|
      { 
        id:product.id, 
        quantity: product.quantity,
        sum: product.quantity * product.product.price 
      } 
    end
  end
end
