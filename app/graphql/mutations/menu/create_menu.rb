# frozen_string_literal: true

module Mutations
  module Menu
    class CreateMenu < BaseMutation
      argument :menu, Types::Arguments::Menu, required: true

      type Types::Custom::Menu

      def resolve(menu: nil)
        Resolvers::Mutations::CreateMenu.new(context, arguments).run
      end

      def ready?(**_args)
        user_required && authorized
      end

      def is_authorized?
        is_super_admin? || is_restuarant_owner?
      end
    end
  end
end
