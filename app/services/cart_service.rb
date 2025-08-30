class CartService
  def initialize(cart)
    @cart = cart
  end

  def add_product(params)
    item = find_or_build_item(params[:product_id])
    item.quantity += params[:quantity].to_i
    item.save!
    @cart
  end

  def update_quantity(params)
    item = find_or_build_item(params[:product_id])
    item.quantity = params[:quantity].to_i
    item.save!
    @cart
  end

  def remove_product(params)
    item = @cart.cart_items.find_by(product_id: params[:product_id])
    raise ActiveRecord::RecordNotFound, "Produto não encontrado" unless item
    item.destroy!
    @cart
  end

  private

  def find_or_build_item(product_id)
    product = Product.find(product_id)
    @cart.cart_items.find_or_initialize_by(product: product)
  end
end
