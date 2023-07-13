class ReservationsController < ApplicationController
  before_action :configure_params

  def index
    @reservations = Reservation.all
  end

  def show
  end

  def create
  end

  def destroy
  end

  private

  def configure_params
    params.require(:reservation).permit(:date, :city, :user_id, :product_id)
  end
end
