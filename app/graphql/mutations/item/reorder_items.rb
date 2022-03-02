# frozen_string_literal: true

module Mutations
  module Item
    class ReorderItems < BaseMutation
      argument :section_id, ID, required: true
      argument :items, [Types::Arguments::ReorderItemsAttributes], required: true

      type [Types::Custom::Item]

      def resolve(section_id: nil, items: nil)
        Resolvers::Mutations::Item::ReorderItems.new(context, arguments).run
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