module Resolvers
  module Queries
    class BaseQueryResolver < GraphQL::Schema::Resolver
      include GqlAuthorization
    end
  end
end
