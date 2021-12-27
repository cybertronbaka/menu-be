# frozen_string_literal: true

module Mutations
  module Table
    class DeleteTable < BaseMutation
      argument :id, ID, required: true

      type Types::Custom::Table

      def resolve(id: nil)
        Resolvers::Mutations::Table::DeleteTable.new(context, arguments).run
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