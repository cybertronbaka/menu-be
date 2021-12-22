# frozen_string_literal: true

module Resolvers
  module Mutations
    module Section
      class EditSection < BaseMutationResolver
        def run
          raise Unauthorized unless owner?

          section.update!(**params[:section].as_json)
          section.reload
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
