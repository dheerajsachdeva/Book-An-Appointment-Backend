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

  private

  def current_user
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             ENV.fetch('DEVISE_JWT_SECRET_KEY', nil)).first
    User.find(jwt_payload['sub'])
  end

end