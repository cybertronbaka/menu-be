# frozen_string_literal: true

module Mutations
  module Item
    class CreateItem < BaseMutation
      argument :section_id, ID, required: true
      argument :item, Types::Arguments::CreateItemAttributes, required: true

      type Types::Custom::Item

      def resolve(section_id: nil, item: nil)
        Resolvers::Mutations::Item::CreateItem.new(context, arguments).run
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