module Types
  module Arguments
    class UserEditAttributes < Types::BaseInputObject
      argument :mobile, String, required: true
    end
  end
end
