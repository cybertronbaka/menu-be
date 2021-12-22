# frozen_string_literal: true

module Resolvers
  module Mutations
    module Menu
      class EditMenu < BaseMutationResolver
        def run
          raise Unauthorized unless owner?

          menu.update!(**params[:menu].as_json)
          menu.reload
        end

        private

        def menu
          @menu ||= ::Menu.find(params[:id].to_i)
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
