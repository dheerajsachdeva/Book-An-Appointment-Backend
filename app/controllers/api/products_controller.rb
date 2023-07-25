class Api::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :get_product
  # before_action :body_data

  def index
    @products = Product.all
    render json: @products
  end

  def show
    @product = Product.find(params[:id])
    render json: @product
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: "No product with that id is found." }, status: :not_found
  end

  def create
    item = request.content_type == "application/json" ? request.raw_post : "{}"
    @product = Product.new(JSON.parse(item))
    if @product.save
      render json: { message: "Product creation successful" }, status: :created
      return
    end
  end

  def update
    if @product.update(body_data)
      render json: { message: "#{@product[:name]} update was successful" }, status: :ok
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @name = @product[:name]
    if @product.destroy
      render json: { message: " #{@product[:name]} deleted successfully" }, status: :ok
      return
    end
  end

  private

  def body_data
    @request_body = request.content_type == "application/json" ? request.raw_post : "{}"
    parsed_params = JSON.parse(@request_body)
  end

  def get_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
  end
end
