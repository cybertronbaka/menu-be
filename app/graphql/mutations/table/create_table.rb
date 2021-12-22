# frozen_string_literal: true

module Mutations
  module Table
    class CreateTable < BaseMutation
      argument :menu_id, ID, required: true
      argument :table, Types::Arguments::CreateTableAttributes, required: true

      type Types::Custom::Table

      def resolve(menu_id: nil, section: nil)
        Resolvers::Mutations::Table::CreateTable.new(context, arguments).run
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