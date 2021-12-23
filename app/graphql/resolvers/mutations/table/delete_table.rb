# frozen_string_literal: true

module Resolvers
  module Mutations
    module Table
      class DeleteTable < BaseMutationResolver
        delegate :menu, to: :table
        def run
          raise Unauthorized unless owner?

          table.destroy!
          table
        end

        private

        def table
          @table ||= ::Table.find(params[:id].to_i)
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
