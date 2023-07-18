class Api::Users::SessionsController < Devise::SessionsController
  # include RackSessionFixController
  respond_to :json

  private

  def respond_with(resource, options = {})
    render json: {
      status: { code: 200, message: 'Logged in sucessfully.' },
      data: current_user
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
  current_user = User.find(jwt_payload['sub'])
  if current_user
    render json: {
      status: 200,
      message: 'logged out successfully'
    }, status: :ok
  else
    render json: {
      status: 401,
      message: "Couldn't find an active session."
    }, status: :unauthorized
  end
  end
  skip_before_action :verify_authenticity_token
  
end