module AuthHandler
  def authenticate_user_without_error
    @current_user = warden.authenticate({})
  rescue StandardError => e
    @current_user = nil
  end

  def authenticate_user!
    @current_user = warden.authenticate!({})
  end
end
