# frozen_string_literal: true

module Resolvers
  module Queries
    module Item
      class ItemResolver < BaseQueryResolver
        type Types::Custom::Item, null: false

        argument :id, ID, required: true

        delegate :section, to: :item
        delegate :menu, to: :section

        def resolve(id: nil)
          raise Unauthorized unless owner?

          item
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def item
          @item ||= ::Item.find(arguments[:id].to_i)
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
