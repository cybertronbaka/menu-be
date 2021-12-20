module Types
  module Arguments
    class UserCreationAttributes < Types::BaseInputObject
      argument :email, String, required: true
      argument :mobile, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
    end
  end
end