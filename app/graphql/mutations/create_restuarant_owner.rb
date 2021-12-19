#frozen_string_literal: true

module Mutations
    class CreateRestuarantOwner < BaseMutation
      # arguments passed to the `resolve` method
      argument :email, String, required: true
      argument :mobile, String, required: true
      argument :name, String, required: true
      argument :address, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
  
      # return type from the mutation
      type Types::Custom::User
  
      def resolve(email: nil, mobile: nil, name: nil, address: nil, password: nil, password_confirmation: nil)
        binding.pry
        Resolvers::CreateRestuarantOwner.new(
          email: email,
          mobile: mobile,
          name: name,
          address: address,
          password: password,
          password_confirmation: password_confirmation
        ).run
      end
    end
  end
  