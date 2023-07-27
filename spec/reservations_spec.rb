# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Reservations/get', type: :request do
  describe 'GET /api/reservations' do
    before(:each) do
      @user = User.create(name: 'Test', email: 'test@example.com', password: 'password',
                          password_confirmation: 'password')
      @product = Product.create(name: 'test', image: 'test.jpg', description: 'test description', model: '2023',
                                engine: '2500 cc', price: 500_000, mileage: 20)
      @reservation = Reservation.create(city: 'test city', date: '2020-02-02', user: @user, product: @product)
      sign_in @user
      get '/api/reservations', headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end

    let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil).first }

    it 'returns http_status :success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns page text containing "test city"' do
      expect(response.body).to include('test city')
    end

    it 'returns response status 200' do
      expect(response.status).to eq(200)
    end
  end
end


RSpec.describe 'Reservations/post', type: :request do
  describe 'POST /api/reservations' do
    before(:each) do
      @user = User.create(name: 'Test', email: 'test@example.com', password: 'password',
                          password_confirmation: 'password')
      @product = Product.create(name: 'test', image: 'test.jpg', description: 'test description', model: '2023',
                                engine: '2500 cc', price: 500_000, mileage: 20)
      sign_in @user
    end

    let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil).first }

    it 'creates a new reservation' do
      reservation_params = {
        city: 'another city',
        date: '2023-07-25',
        user_id: @user.id,
        product_id: @product.id
      }

      post '/api/reservations', params: { reservation: reservation_params },
                                headers: { 'Authorization' => "Bearer #{jwt_token}" }

      expect(response).to have_http_status(:success)
      expect(response.body).to include('another city')
      expect(response.status).to eq(200)

      expect(Reservation.last.city).to eq('another city')
      expect(Reservation.last.date).to eq(Date.parse('2023-07-25'))
      expect(Reservation.last.user_id).to eq(@user.id)
      expect(Reservation.last.product_id).to eq(@product.id)
    end
  end
end

RSpec.describe 'Reservations/delete', type: :request do
  describe 'DELETE /api/reservations/:id' do
    before(:each) do
      @user = User.create(name: 'Test', email: 'test@example.com', password: 'password',
                          password_confirmation: 'password')
      @product = Product.create(name: 'test', image: 'test.jpg', description: 'test description', model: '2023',
                                engine: '2500 cc', price: 500_000, mileage: 20)
      @reservation = Reservation.create(city: 'test city', date: '2020-02-02', user: @user, product: @product)
      sign_in @user
    end

    let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil).first }

    it 'deletes a reservation' do
      delete "/api/reservations/#{@reservation.id}", headers: { 'Authorization' => "Bearer #{jwt_token}" }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('{"status":"Success","message":"Deleted Reservation"}')

      expect(Reservation.find_by(id: @reservation.id)).to be_nil
    end
  end
end
