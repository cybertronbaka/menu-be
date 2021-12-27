# frozen_string_literal: true

module Resolvers
  module Mutations
    module Order
      class CreateOrder < BaseMutationResolver
        delegate :user, to: :menu

        def run
          order
        end

        private

        def order
          @order ||= ::Order.create!(**params[:order].as_json, restaurant_owner: user)
        end

        def menu
          @menu ||= ::Menu.find_by!(token: params[:token].to_s)
        end
      end
    end
  end
end
