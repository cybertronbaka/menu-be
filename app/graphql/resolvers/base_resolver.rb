# frozen_string_literal: true

module Resolvers
    class BaseResolver
        attr_accessor :params

        def initialize(**args)
            @params = args
        end

        def run
            raise NotImplementedError
        end
    end
end