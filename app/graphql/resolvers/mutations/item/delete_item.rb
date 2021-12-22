# frozen_string_literal: true

module Resolvers
  module Mutations
    module Item
      class DeleteItem < BaseMutationResolver
        delegate :section, to: :item
        delegate :menu, to: :section

        def run
          raise Unauthorized unless owner?

          item.destroy!
          item
        end

        private

        def item
          @item ||= ::Item.find(params[:id].to_i)
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
