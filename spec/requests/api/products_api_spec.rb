require 'rails_helper'

RSpec.describe 'Products', type: :request do
     before(:each) do
        @product = Product.create(name: 'test', image: 'test.jpg', description: "test description", model:"2023", engine: "2500 cc", price: 500000, mileage: 20)
      end

      describe 'GET /index' do
        path '/api/products' do
          get 'Retrieves all the Cars' do
            tags 'Cars'
            produces 'application/json'
    
            response '200', 'cars list' do
              run_test! do |response|
                expect(response).to have_http_status(:ok)
              end
            end
          end
        end
      end
    end

RSpec.describe 'Products/show', type: :request do
     let(:id) do
        Product.create(name: 'test', image: 'test.jpg', description: "test description", model: "2023", engine: "2500 cc", price: 500000, mileage: 20).id
      end
    
    describe 'GET /show' do
      path '/api/products/{id}' do
        get 'Retrieves a Car' do
          tags 'Cars'
          produces 'application/json'
          parameter name: :id, in: :path, type: :string
  
          response '200', 'Car' do
            run_test! do |response|
              expect(response.body).to include('test')
              expect(response.body).to include('test.jpg')
            end
          end
        end
      end
    end
  end

RSpec.describe 'Products/delete', type: :request do
          let(:id) do
          Product.create(name: 'test', image: 'test.jpg', description: "test description", model: "2023", engine: "2500 cc", price: 500000, mileage: 20).id
        end
        
        describe 'DELETE /destory' do
    path '/api/products/{id}' do
      delete 'Delete a car' do
        tags 'Cars'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        response '200', 'Car' do
          let(:id) { @service.id }
          run_test!
        end
      end
    end
  end

 end