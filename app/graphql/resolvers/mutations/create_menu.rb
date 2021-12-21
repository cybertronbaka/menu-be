# frozen_string_literal: true

module Resolvers
  module Mutations
    class CreateMenu < BaseMutationResolver
      def run
        menu
      end

      private

      def menu
        @menu ||= Menu.create!(**params[:menu], user: context[:current_user])
      end
    end
  end
end
