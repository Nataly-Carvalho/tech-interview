class ProductsController < ApplicationController
  before_action :product, only: %i[ show update destroy ]

  # GET /products
  def index
    @products = Product.all

    render json: @products.map { |product| ProductSerializer.call(product) }
  end

  # GET /products/1
  def show
    render json: ProductSerializer.call(@product)
  end

  # POST /products
  def create
    product = Product.create!(permitted_params)
    render json: ProductSerializer.call(product), status: :created
  end

  # PATCH/PUT /products/1
  def update
    product.update!(permitted_params)
    render json: ProductSerializer.call(product), status: :ok
  end

  # DELETE /products/1
  def destroy
    product.destroy!
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def product
      @product ||= Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def permitted_params
      params.require(:product).permit(:name, :unit_price)
    end
end
