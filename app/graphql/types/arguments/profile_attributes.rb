module Types
  module Arguments
    class ProfileAttributes < Types::BaseInputObject
      argument :name, String, required: true
      argument :address, String, required: true
    end
  end
end