# frozen_string_literal: true

module Types
  module Custom
    class DefaultResponse < BaseObject
      field :success, Boolean, null: false
    end
  end
end
