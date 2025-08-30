class ProductSerializer

  def self.call(product)
    {
      id: product.id,
      name: product.name,
      unit_price: product.unit_price
    }
  end
end
