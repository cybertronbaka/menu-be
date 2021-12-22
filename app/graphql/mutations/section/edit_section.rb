# frozen_string_literal: true

module Mutations
  module Section
    class EditSection < BaseMutation
      argument :id, ID, required: true
      argument :section, Types::Arguments::SectionAttributes, required: true

      type Types::Custom::Section

      def resolve(id: nil, section: nil)
        Resolvers::Mutations::Section::EditSection.new(context, arguments).run
      end

      def ready?(**_args)
        user_required && authorized
      end

      def is_authorized?
        is_restuarant_owner?
      end
    end
  end
end