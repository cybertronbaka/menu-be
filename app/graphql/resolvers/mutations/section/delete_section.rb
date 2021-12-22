# frozen_string_literal: true

module Resolvers
  module Mutations
    module Section
      class DeleteSection < BaseMutationResolver
        def run
          raise Unauthorized unless owner?

          section.destroy!
          section
        end

        private

        def section
          @section ||= ::Section.find(params[:id].to_i)
        end

        def owner?
          context[:current_user].id == section.menu.user_id
        end
      end
    end
  end
end
