module Types
  module Arguments
    class ProfileAttributes < Types::BaseInputObject
      argument :name, String, required: true
      argument :address, String, required: true
      argument :description, String, required: false
    end
  end
end
