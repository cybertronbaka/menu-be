# frozen_string_literal: true

module Resolvers
  module Mutations
    module Menu
      class DeleteMenu < BaseMutationResolver
        def run
          raise Unauthorized unless owner?

          menu.destroy!
          menu
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
