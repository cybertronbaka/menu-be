# frozen_string_literal: true

module Resolvers
  module Mutations
    module Item
      class CreateItem < BaseMutationResolver
        delegate :menu, to: :section

        def run
          raise Unauthorized unless owner?

          item
        end

        private

        def item
          @item ||= ::Item.create!(**params[:item].as_json, section: section)
        end

        def section
          @section ||= ::Section.find(params[:section_id])
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
