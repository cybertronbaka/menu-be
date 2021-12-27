# frozen_string_literal: true

module Resolvers
  module Queries
    module Order
      class OrderResolver < BaseQueryResolver
        type Types::Custom::Order, null: false

        argument :id, ID, required: true

        def resolve(id: nil)
          raise Unauthorized unless owner?

          order
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def order
          @order ||= ::Order.find(arguments[:id].to_i)
        end

        def owner?
          context[:current_user].id == order.restaurant_owner_id
        end
      end
    end
  end
end
