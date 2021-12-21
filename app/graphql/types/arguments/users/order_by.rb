module Types
  module Arguments
    module Users
      class OrderBy < Types::BaseEnum
        value 'id', 'id field'
        value 'email', 'email field'
        value 'mobile', 'mobile field'
        value 'created_at', 'created at field'
      end
    end
  end
end
