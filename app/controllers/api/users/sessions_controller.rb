class Api::Users::SessionsController < Devise::SessionsController
  # include RackSessionFixController
  skip_before_action :verify_authenticity_token
  
end