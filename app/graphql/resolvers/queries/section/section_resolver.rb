# frozen_string_literal: true

module Resolvers
  module Queries
    module Section
      class SectionResolver < BaseQueryResolver
        type Types::Custom::Section, null: false

        argument :id, ID, required: true

        def resolve(id: nil)
          ::Section.find(arguments[:id].to_i)
        end
      end
    end
  end
end
