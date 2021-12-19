module Api
    module V1
        class SessionsController < Devise::SessionsController
            include RestErrorHandler
            prepend_before_action :authenticate_user!, only: [:destroy]

            def create
                self.resource = warden.authenticate!(auth_options)
                if resource
                    render json: { data: { message: "Signed In succesfully!" }}, status: 200
                end
            end

            def destroy
                return render_error(401, "You need to Sign In or Sign Up to perform this action.") unless current_user

                Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
                render json: { data: { message: "Signed out successfully" }}, status: 200
            end

            def respond_to
                [:json]
            end
        end
    end
end
