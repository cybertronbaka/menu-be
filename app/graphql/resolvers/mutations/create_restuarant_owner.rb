# frozen_string_literal: true

module Resolvers
    module Mutations
        class CreateRestuarantOwner < BaseMutationResolver
            def run
                user && profile
                user
            end

            private

            def user
                @user ||= User.create!(
                    email: params[:email],
                    mobile: params[:mobile],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation],
                    role_id: 2
                )
            end

            def profile
                @profile ||= Profile.create!(name: params[:name], address: params[:address], user: user)
            end
        end
    end
end