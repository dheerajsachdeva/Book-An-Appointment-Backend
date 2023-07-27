module Api
  module Users
    class RegistrationsController < Devise::RegistrationsController
      skip_before_action :verify_authenticity_token
      # include RackSessionFixController

      respond_to :json

      private

      def respond_with(resource, _options = {})
        if resource.persisted?
          render json: {
            status: { code: 200, message: 'Signed up sucessfully.' },
            data: resource
          }
        else
          render json: {
            status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
          }, status: :unprocessable_entity
        end
      end
    end
  end
end
