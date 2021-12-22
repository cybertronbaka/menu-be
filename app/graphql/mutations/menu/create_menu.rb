# frozen_string_literal: true

module Mutations
  module Menu
    class CreateMenu < BaseMutation
      argument :menu, Types::Arguments::MenuAttributes, required: true

      type Types::Custom::Menu

      def resolve(menu: nil)
        Resolvers::Mutations::Menu::CreateMenu.new(context, arguments).run
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
