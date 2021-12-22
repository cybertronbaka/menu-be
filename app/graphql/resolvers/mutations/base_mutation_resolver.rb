# frozen_string_literal: true

module Resolvers
  module Mutations
    class BaseMutationResolver
      attr_accessor :params, :context

      def initialize(context, args)
        @context = context
        @params = args
      end

      def run
        raise NotImplementedError
      end
    end
  end
end
