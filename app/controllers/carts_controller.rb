class CartsController < ApplicationController
  before_action :set_cart

  def show
    render json: CartSerializer.call(@cart)
  end

  def create
    cart = CartService.new(@cart).add_product(permitted_params)
    render json: CartSerializer.call(cart), status: :created
  end

  def update
    cart = CartService.new(@cart).update_quantity(permitted_params)
    render json: CartSerializer.call(cart), status: :ok
  end

  def destroy
    cart = CartService.new(@cart).remove_product(permitted_params)
    render json: CartSerializer.call(cart), status: :ok
  end

  private

  def permitted_params
    params.require(:cart).permit(:product_id, :quantity)
  end

  def set_cart
    @cart ||= Cart.find_by(id: session[:cart_id], status: :active)
    unless @cart
      @cart = Cart.create!(status: :active, total_price: 0)
      session[:cart_id] = @cart.id
    end
  end
end
