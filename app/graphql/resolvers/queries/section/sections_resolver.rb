# frozen_string_literal: true

module Resolvers
  module Queries
    module Section
      class SectionsResolver < BaseQueryResolver
        include GqlPagination

        type Types::Custom::SectionList, null: false

        argument :menu_id, ID, required: true

        def resolve(**args)
          raise Unauthorized unless owner?

          paginate(::Section.where(menu_id: args[:menu_id]).order(rank: :asc), 'sections')
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def menu
          @menu ||= ::Menu.find(arguments[:menu_id].to_i)
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
