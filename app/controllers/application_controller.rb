class ApplicationController < ActionController::API
    include AuthHandler

    attr_accessor :current_user
end
