# frozen_string_literal: true

module Resolvers
  module Mutations
    module Item
      class EditItem < BaseMutationResolver
        delegate :section, to: :item
        delegate :menu, to: :section

        def run
          raise Unauthorized unless owner?

          item.update!(**params[:item].as_json)
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
