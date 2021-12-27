# frozen_string_literal: true

module Types
  module Arguments
    class EditOrderAttributes < Types::BaseInputObject
      argument :table_no, Integer, required: false
      argument :status, Types::Arguments::Order::OrderStatus, required: false
    end
  end
end
