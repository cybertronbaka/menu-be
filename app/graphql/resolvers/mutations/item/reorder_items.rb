# frozen_string_literal: true

module Resolvers
  module Mutations
    module Item
      class ReorderItems < BaseMutationResolver
        delegate :menu, to: :section

        def run
          raise Unauthorized unless owner?

          params[:items].each do |item|
            ::Item.find(item[:id]).update!(rank: item.rank)
          end
        end

        private

        def owner?
          context[:current_user].id == menu.user_id
        end

        def section
          @section ||= ::Section.find(params[:section_id])
        end
      end
    end
  end
end
