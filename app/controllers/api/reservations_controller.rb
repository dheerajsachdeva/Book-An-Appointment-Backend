class Api::ReservationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
    def index
      reserved = []
     
      current_user.reservations.each do |reservation|
        reserved << {
            id: reservation.id,
            date: reservation.date,
            city: reservation.city,
            product: reservation.product,
            user: reservation.user.name
      }
    end
      if reserved.present?
        render json: { status: 'Success', message: 'Loaded Reservations', data: reserved }, status: :ok
      else
        render json: { status: 'Not Found', message: 'Reservations not found'},
               status: :unprocessable_entity
      end
    end
  def show
    @reservation = Reservation.find(params[:id])
    if @reservation.present?
        render json: { status: 'Success', message: 'Loaded Reservation', data: @reservation }, status: :ok
      else
        render json: { status: 'Not Found', message: 'Reservations not found', data: @reservation.errors },
               status: :unprocessable_entity
      end
    end
    def create
    @reservation = current_user.reservations.new(reservation_params)

    if @reservation.save
        render json: { status: 'Success', message: 'Loaded Reservation', data: @reservation }, status: :ok
      else
        render json: { status: 'Not Found', message: 'Reservations not found', data: @reservation.errors },
               status: :unprocessable_entity
      end
    end
    def update
        @reservation = Reservation.find(params[:id])
        if @reservation.empty?
            render json: { status: 'Not Found', message: 'Reservations not found', data: @reservation.errors },
                   status: :unprocessable_entity
        else @reservation.update(reservation_params)
                   render json: { status: 'Success', message: 'Loaded Reservation', data: @reservation }, status: :ok
          end
    end
    def destroy
        @reservation = Reservation.find(params[:id])
        if @reservation.empty?
            render json: { status: 'Not Found', message: 'Reservations not found', data: @reservation.errors },
                   status: :unprocessable_entity
        else @reservation.destroy
                   render json: { status: 'Success', message: 'Deleted Reservation'}, status: :ok
          end
    end
    private
    def reservation_params
        params.require(:reservation).permit(:date, :city, :product_id)
    end
      
    def current_user
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
            User.find(jwt_payload['sub'])
    end
    
  end
  
