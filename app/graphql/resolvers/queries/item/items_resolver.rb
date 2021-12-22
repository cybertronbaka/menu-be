# frozen_string_literal: true

module Resolvers
  module Queries
    module Item
      class ItemsResolver < BaseQueryResolver
        include GqlPagination
        type Types::Custom::ItemList, null: false

        argument :section_id, ID, required: true

        delegate :menu, to: :section

        def resolve(section_id: nil)
          raise Unauthorized unless owner?

          paginate(::Item.where(section_id: section_id).order(rank: :asc), 'items')
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def section
          @section ||= ::Section.find(arguments[:section_id].to_i)
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
