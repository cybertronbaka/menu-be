# frozen_string_literal: true

module Resolvers
  module Mutations
    module Menu
      class CreateMenu < BaseMutationResolver
        def run
          menu
        end

        private

        def menu
          @menu ||= ::Menu.create!(**params[:menu].as_json, user: context[:current_user])
        end
      end
    end
  end
end
