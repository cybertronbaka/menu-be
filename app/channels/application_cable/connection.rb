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
      return reject_unauthorized_connection unless env['warden'].user

      env['warden'].user
    end
  end
end
