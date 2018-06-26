class Api::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price
end
