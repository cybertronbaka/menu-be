module Types
    module Custom
        class User < BaseObject
            field :id, ID, null: false
            field :email, String, null: false
            field :mobile, String, null: false
            field :profile, GraphQL::Types::JSON, null: false
        end
    end
end
