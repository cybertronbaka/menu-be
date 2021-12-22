# frozen_string_literal: true

module Types
  module Custom
    class SectionList < BaseObject
      field :page_info, Types::Custom::PageInfo, null: true
      field :sections, [Types::Custom::Section], null: true
    end
  end
end
