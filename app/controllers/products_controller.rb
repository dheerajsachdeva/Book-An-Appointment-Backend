class ProductsController < ApplicationController
  before_action :configure_params

  def index
    @products = Product.all
  end

  def show
  end

  def create
  end

  def destroy
  end

  private

  def configure_params
    params.require(:product).permit(:name, :image, :description, :model, :engine, :price, :mileage)
  end
end
