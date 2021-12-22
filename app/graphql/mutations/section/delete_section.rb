# frozen_string_literal: true

module Mutations
  module Section
    class DeleteSection < BaseMutation
      argument :id, ID, required: true

      type Types::Custom::Section

      def resolve(id: nil)
        Resolvers::Mutations::Section::DeleteSection.new(context, arguments).run
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