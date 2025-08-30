class CartSerializer
  def self.call(cart)
    {
      id: cart.id,
      products: cart.cart_items.map do |item|
        {
          id: item.product.id,
          name: item.product.name,
          unit_price: item.unit_price,   # <- pega do cart_item, não do product
          quantity: item.quantity,
          total_price: item.total_price
        }
      end,
      total_price: cart.total_price
    }
  end
end
