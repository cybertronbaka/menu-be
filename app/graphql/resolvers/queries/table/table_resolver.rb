# frozen_string_literal: true

module Resolvers
  module Queries
    module Table
      class TableResolver < BaseQueryResolver
        type Types::Custom::Table, null: false

        argument :id, ID, required: true

        delegate :menu, to: :table

        def resolve(id: nil)
          raise Unauthorized unless owner?

          table
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def table
          @table ||= ::Table.find(arguments[:id].to_i)
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
