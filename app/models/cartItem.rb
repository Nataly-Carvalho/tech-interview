class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  before_save :set_prices
  after_save :update_cart_total
  after_destroy :update_cart_total

  private

  def set_prices
    self.unit_price ||= product.unit_price
    self.total_price = quantity.to_i * unit_price.to_f
  end

  def update_cart_total
    cart.update!(total_price: cart.cart_items.sum(:total_price))
  end
end
