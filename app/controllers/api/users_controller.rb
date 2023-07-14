class Api::UsersController < ApplicationController
    
    def index
      @users = User.all
      render json: { status: 'Success', message: 'Loaded Reservations', data: @users }, status: :ok
    end
  
    
  end
  