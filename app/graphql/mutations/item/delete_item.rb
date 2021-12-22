# frozen_string_literal: true

module Mutations
  module Item
    class DeleteItem < BaseMutation
      argument :id, ID, required: true

      type Types::Custom::Item

      def resolve(id: nil)
        Resolvers::Mutations::Item::DeleteItem.new(context, arguments).run
      end

      def ready?(**_args)
        user_required && authorized
      end

      def is_authorized?
        is_restuarant_owner?
      end
    end
  end
end