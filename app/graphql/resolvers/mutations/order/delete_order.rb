# frozen_string_literal: true

module Resolvers
  module Mutations
    module Order
      class DeleteOrder < BaseMutationResolver
        def run
          raise Unauthorized unless owner?

          order.destroy!
          order
        end

        private

        def order
          @order ||= ::Order.find(params[:id].to_i)
        end

        def owner?
          context[:current_user].id == order.restaurant_owner_id
        end
      end
    end
  end
end
