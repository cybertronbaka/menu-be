# frozen_string_literal: true

module Resolvers
  module Queries
    module Item
      class ItemsResolver < BaseQueryResolver
        include GqlPagination
        type Types::Custom::ItemList, null: false

        argument :section_id, ID, required: true

        def resolve(section_id: nil)
          paginate(::Item.where(section_id: section_id).order(rank: :asc), 'items')
        end

        private

        def section
          @section ||= ::Section.find(arguments[:section_id].to_i)
        end
      end
    end
  end
end
