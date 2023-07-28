require 'swagger_helper'
require 'devise/jwt/test_helpers'
RSpec.describe 'Reservations/get', type: :request do
  before(:each) do
    @user = User.create(name: 'Test', email: 'test@example.com', password: 'password',
                        password_confirmation: 'password')
    @product = Product.create(name: 'test', image: 'test.jpg', description: 'test description', model: '2023',
                              engine: '2500 cc', price: 500_000, mileage: 20)
    @user.confirm
    @reservation = Reservation.create(city: 'test city', date: '2020-02-02', user: @user, product: @product)
  end

  describe 'GET /index' do
    path '/api/reservations' do
      get 'Get Reserved Cars for Current User' do
        tags 'Reservation'
        produces 'application/json'
        security [bearer_auth: []]

        response '200', 'cars list' do
          before do
            sign_in @user
          end
          include Devise::JWT::TestHelpers
          let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil).first }
          let(:Authorization) { "Bearer #{jwt_token}" }
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.body).to include('test city')
            expect(response.body).to include('2020-02-02')
          end
        end
      end
    end
  end
end

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Reservations/post', type: :request do
  before(:each) do
    @user = User.create(name: 'Test', email: 'test@example.com', password: 'password',
                        password_confirmation: 'password')
    @product = Product.create(name: 'test', image: 'test.jpg', description: 'test description', model: '2023',
                              engine: '2500 cc', price: 500_000, mileage: 20)
  end

  describe 'POST /create' do
    path '/api/reservations' do
      post 'Reserve car for current user' do
        tags 'Reservation'
        consumes 'application/json'
        produces 'application/json'
        security [bearer_auth: []]
        parameter name: :reservations, in: :body, schema: {
          type: :object,
          properties: {
            reservations: {
              type: :object,
              properties: {
                city: { type: :string },
                date: { type: :string },
                product_id: { type: :number }
              },
              required: %w[city date product_id]
            }
          },
          required: ['reservations']
        }

        response '200', 'Reservation created' do
          before do
            sign_in @user
          end
          include Devise::JWT::TestHelpers
          let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil).first }
          let(:Authorization) { "Bearer #{jwt_token}" }
          let(:reservations) do
            { reservations: { city: 'City Created', date: '2021-01-01', product_id: @product.id } }
          end

          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response.body).to include('Reservation created sucessfully')
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

RSpec.describe 'Reservations/delete', type: :request do
  before(:each) do
    @user = User.create(name: 'Test', email: 'test@example.com', password: 'password',
                        password_confirmation: 'password')
    @product = Product.create(name: 'test', image: 'test.jpg', description: 'test description', model: '2023',
                              engine: '2500 cc', price: 500_000, mileage: 20)
    @reservation = Reservation.create(city: 'test city', date: '2020-02-02', user: @user, product: @product)
  end

  describe 'DELETE /destory' do
    path '/api/reservations/{id}' do
      delete 'Delete a Reservation' do
        tags 'Reservation'
        consumes 'application/json'
        produces 'application/json'
        security [bearer_auth: []]
        parameter name: :id, in: :path, type: :string

        response '204', 'Reservation Deleted' do
          before do
            sign_in @user
          end
          include Devise::JWT::TestHelpers
          let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil).first }
          let(:Authorization) { "Bearer #{jwt_token}" }

          let(:id) { @reservation.id }
          run_test!
        end
      end
    end
  end
end
