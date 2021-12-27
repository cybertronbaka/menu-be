# frozen_string_literal: true

module Resolvers
  module Queries
    module Item
      class ItemResolver < BaseQueryResolver
        type Types::Custom::Item, null: false

        argument :id, ID, required: true

        def resolve(id: nil)
          ::Item.find(arguments[:id].to_i)
        end
      end
    end
  end
end
