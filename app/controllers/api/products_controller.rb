module Api
  class ProductsController < ApplicationController
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
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'No product with that id is found.' }, status: :not_found
    end

    def create
      item = request.content_type == 'application/json' ? request.raw_post : '{}'
      @product = Product.new(JSON.parse(item))
      if @product.save
        render json: { status: :created }
        nil
      else
        render json: { message: 'Sorry, the product failed to create.', status: :internal_server_error }
      end
    end

    def update
      return unless @product.update(body_data)

      render json: { message: "#{@product[:name]} update was successful" }, status: :ok
    end

    def destroy
      @product = Product.find(params[:id])
      @name = @product[:name]
      if @product.destroy
        render json: { message: " #{@product[:name]} deleted successfully" }, status: :ok
        nil
      else
        render json: { message: "Failed to destroy #{@product[:name]} as something went wrong" },
               status: :internal_server_error
      end
    end

    private

    def body_data
      @request_body = request.content_type == 'application/json' ? request.raw_post : '{}'
      JSON.parse(@request_body)
    end
  end
end
