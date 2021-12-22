# frozen_string_literal: true

module Mutations
  module Item
    class EditItem < BaseMutation
      argument :id, ID, required: true
      argument :item, Types::Arguments::EditItemAttributes, required: true

      type Types::Custom::Item

      def resolve(id: nil, item: nil)
        Resolvers::Mutations::Item::EditItem.new(context, arguments).run
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