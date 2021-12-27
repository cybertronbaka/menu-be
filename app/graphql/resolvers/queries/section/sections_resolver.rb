# frozen_string_literal: true

module Resolvers
  module Queries
    module Section
      class SectionsResolver < BaseQueryResolver
        include GqlPagination

        type Types::Custom::SectionList, null: false

        argument :menu_id, ID, required: true

        def resolve(**args)
          paginate(::Section.where(menu_id: args[:menu_id]).order(rank: :asc), 'sections')
        end

        private

        def menu
          @menu ||= ::Menu.find(arguments[:menu_id].to_i)
        end
      end
    end
  end
end
