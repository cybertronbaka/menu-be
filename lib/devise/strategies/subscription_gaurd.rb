# frozen_string_literal: true

module Devise
  module Strategies
    class SubscriptionGaurd < Authenticatable
      def valid?
        fail!('Your Subscription has been Cancelled! Please contact us to resolve this.') if cancelled?
      end

      def authenticate!
        true
      end

      private

      def cancelled?
        params[:controller] == 'api/v1/sessions' && user&.cancelled?
      end

      def user
        @user ||= User.find_by(email: params.dig(:user, :email))
      end
    end
  end
end
