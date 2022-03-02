# frozen_string_literal: true

module Resolvers
  module Mutations
    module Section
      class ReorderSections < BaseMutationResolver
        def run
          raise Unauthorized unless owner?

          params[:sections].each do |item|
            ::Section.find(item[:id]).update!(rank: item.rank)
          end
        end

        private

        def owner?
          context[:current_user].id == menu.user_id
        end

        def menu
          @menu ||= ::Menu.find(params[:menu_id])
        end
      end
    end
  end
end
