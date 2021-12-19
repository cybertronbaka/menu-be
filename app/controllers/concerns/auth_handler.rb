module AuthHandler
    def authenticate_user_without_error
        begin
            @current_user = warden.authenticate({})
        rescue => exception
            @current_user = nil
        end
    end

    def authenticate_user!
        @current_user = warden.authenticate!({})
    end
end