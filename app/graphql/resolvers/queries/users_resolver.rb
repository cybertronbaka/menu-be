module Resolvers
  module Queries
    class UsersResolver < BaseQueryResolver
      include GqlPagination

      type Types::Custom::UserList, null: true

      argument :order_by, Types::Arguments::Users::OrderBy, required: false
      argument :order_direction, Types::Arguments::OrderDirection, required: false
      argument :query, String, required: false
      argument :role_name, Types::Arguments::RoleName, required: true

      def resolve(**args)
        paginate(queried,'users')
      end

      def ready?(**_args)
        user_required && authorized
      end

      def is_authorized?
        is_super_admin?
      end

      private

      def queried
        arguments[:query].blank? ? sorted_users : sorted_users.query(arguments[:query])
      end

      def sorted_users
        User.where(role_id: role_id).order(sort_hash)
      end

      def role_id
        @role_id ||= Role.find_by(name: arguments[:role_name] || 'restuarant_owner').id
      end

      def sort_hash
        @sort_hash ||= { "#{arguments[:order_by] || 'id'}": arguments[:order_direction] || 'asc' }
      end
    end
  end
end
