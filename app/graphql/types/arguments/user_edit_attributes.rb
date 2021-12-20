module Types
  module Arguments
    class UserEditAttributes < Types::BaseInputObject
      argument :email, String, required: true
      argument :mobile, String, required: true
    end
  end
end