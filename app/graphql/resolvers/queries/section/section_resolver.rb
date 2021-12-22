# frozen_string_literal: true

module Resolvers
  module Queries
    module Section
      class SectionResolver < BaseQueryResolver
        type Types::Custom::Section, null: false

        argument :id, ID, required: true

        delegate :menu, to: :section

        def resolve(id: nil)
          raise Unauthorized unless owner?

          section
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def section
          @section ||= ::Section.find(arguments[:id].to_i)
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
