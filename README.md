# Noveo shopping cart

RESTful API shopping cart. You can retrieve the list of available products from shop, add products to cart, delete products from cart, get the detalisation of products currently added to the cart.

Cart TTL is 5 minuts then it flushes.

# Requirements

ruby 2.5.0

# Install & Run

$ cd noveo
$ gem install bundler
$ bundle
$ rake db:seed
$ rails s

# Run test suite

$ rspec

# Usage

1) Get the list of products

```
$ curl http://localhost:3000/api/products

[
    {
        "id": 11,
        "name": "Product 0",
        "description": "Qui nam voluptatem nostrum aut et eligendi. Sed suscipit voluptatem dolorum numquam eius minus. Dolor atque voluptatem soluta veniam dicta debitis doloremque. Molestiae consequatur voluptas in corporis ad quos eum omnis.",
        "price": 96
    },
....
```

2) Add products to cart

```
$ curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"product_id":"11","quantity":"5"}' \
  http://localhost:3000/api/cart
```

3) Delete product from cart

```
curl --request DELETE http://localhost:3000/api/cart/11
```

4) Get the list of products in cart

```
$ curl http://localhost:3000/api/cart

{
    "data": {
        "total_sum": 384,
        "products_count": 4,
        "products": [
            {
                "id": 13,
                "quantity": 4,
                "sum": 384
            }
        ]
    }
}
```

# [EOF]