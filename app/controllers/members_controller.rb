class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      render json: { status: 'Success', message: 'Current User', data: current_user }, status: :ok
    else
      render json: { status: 'Failed', message: 'No user Login'},
             status: :unprocessable_entity
    end

  end

end