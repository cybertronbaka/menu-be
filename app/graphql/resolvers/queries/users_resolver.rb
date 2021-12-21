module Resolvers
  module Queries
    class UsersResolver < BaseQueryResolver
      type [Types::Custom::User], null: false

      argument :order_by, Types::Arguments::Users::OrderBy, required: false
      argument :order_direction, Types::Arguments::OrderDirection, required: false
      argument :query, String, required: false
      argument :role_name, Types::Arguments::RoleName, required: true

      def resolve(role_name: nil, query: nil, order_by: nil, order_direction: nil)
        # TODO: Search to be implemented
        User.where(role_id: role_id).order(sort_hash)
      end

      def ready?(**_args)
        user_required && authorized
      end

      def is_authorized?
        is_super_admin?
      end

      private

      def role_id
        @role_id ||= Role.find_by(name: arguments[:role_name] || 'restuarant_owner').id
      end

      def sort_hash
        @sort_hash ||= { "#{arguments[:order_by] || 'id'}": arguments[:order_direction] || 'asc' }
      end
    end
  end
end
