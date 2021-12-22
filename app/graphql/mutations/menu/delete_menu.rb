# frozen_string_literal: true

module Mutations
  module Menu
    class DeleteMenu < BaseMutation
      argument :id, ID, required: true

      type Types::Custom::Menu

      def resolve(id: nil)
        Resolvers::Mutations::Menu::DeleteMenu.new(context, arguments).run
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
