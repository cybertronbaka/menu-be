# frozen_string_literal: true

module Resolvers
  module Mutations
    module Table
      class CreateTable < BaseMutationResolver
        def run
          raise Unauthorized unless owner?

          section
        end

        private

        def section
          @section ||= ::Table.create!(**params[:table].as_json, menu: menu)
        end

        def menu
          @menu ||= ::Menu.find(params[:menu_id])
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
