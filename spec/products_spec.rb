require 'rails_helper'

RSpec.describe 'Products', type: :request do
  path 'api/products' do
    before(:each) do
        @product = Product.create(name: 'test', image: 'test.jpg', description: "test description", model:"2023", engine: "2500 cc", price: 500000, mileage: 20)
      get '/api/products'
    end

    it 'http_status' do
      expect(response).to have_http_status(:success)
    end

    it 'Text of a page rendered' do
      expect(response.body).to include('test')
    end

    it 'Response status' do
      expect(response.status).to eq(200)
    end

     end
end

RSpec.describe 'Products/show', type: :request do
  describe 'GET api/products/{id}' do
    let(:id) do
        Product.create(name: 'test', image: 'test.jpg', description: "test description", model: "2023", engine: "2500 cc", price: 500000, mileage: 20).id
      end
    before(:each) do
        get "/api/products/#{id}"
    end

    it 'Show http_status' do
      expect(response).to have_http_status(:success)
    end

    it 'Show page text' do
      expect(response.body).to include('test')
    end

    it 'Show Response status' do
      expect(response.status).to eq(200)
    end

      end
end

RSpec.describe 'Products/delete', type: :request do
    describe 'Delete api/products/{id}' do
      let(:id) do
          Product.create(name: 'test', image: 'test.jpg', description: "test description", model: "2023", engine: "2500 cc", price: 500000, mileage: 20).id
        end
      before(:each) do
          delete "/api/products/#{id}"
      end
  
        it 'Show Response status' do
        expect(response.status).to eq(200)
      end
    end
        end