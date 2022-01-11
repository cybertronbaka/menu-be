# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Devise::SessionsController
      include RestErrorHandler
      prepend_before_action :authenticate_user!, only: [:destroy]

      def create
        self.resource = warden.authenticate!(auth_options)
        render json: { data: { message: 'Signed In succesfully!' } }, status: 200 if resource
      end

      def authenticated
        self.resource = warden.authenticate(auth_options.merge(scope: :user))
        render json: { data: { authenticated: resource.present? } }, status: 200
      end

      def destroy
        return (raise Unauthenticated) unless current_user

        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
        render json: { data: { message: 'Signed Out successfully' } }, status: 200
      end

      def respond_to; end
    end
  end
end
