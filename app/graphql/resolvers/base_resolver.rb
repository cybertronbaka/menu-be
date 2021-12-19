# frozen_string_literal: true

module Resolvers
    class BaseResolver
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