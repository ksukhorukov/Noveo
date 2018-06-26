FactoryBot.define do
  factory :product, class: 'Api::Product' do 
    name FFaker::Lorem.word
    description FFaker::Lorem.paragraph
    price 123
  end
end