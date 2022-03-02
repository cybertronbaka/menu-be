# frozen_string_literal: true

module Mutations
  module Section
    class ReorderSections < BaseMutation
      argument :menu_id, ID, required: true
      argument :sections, [Types::Arguments::ReorderSectionsAttributes], required: true

      type [Types::Custom::Section]

      def resolve(menu_id: nil, sections: nil)
        Resolvers::Mutations::Section::ReorderSections.new(context, arguments).run
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