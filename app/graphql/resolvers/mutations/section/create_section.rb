# frozen_string_literal: true

module Resolvers
  module Mutations
    module Section
      class CreateSection < BaseMutationResolver
        def run
          raise Unauthorized unless owner?

          section
        end

        private

        def section
          @section ||= ::Section.create!(**params[:section].as_json, menu: menu)
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
