module Types
  module Arguments
    class Menu < Types::BaseInputObject
      argument :name, String, required: true
      argument :description, String, required: false
    end
  end
end
