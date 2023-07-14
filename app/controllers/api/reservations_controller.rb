class Api::ReservationsController < ApplicationController
      
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
  
    
  end
  