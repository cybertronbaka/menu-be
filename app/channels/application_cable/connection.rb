module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include AuthHandler
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.profile&.name
    end

    protected

    def find_verified_user
      verified_user = authenticate_user_without_error

      return verified_user if verified_user

      reject_unauthorized_connection
    end
  end
end
